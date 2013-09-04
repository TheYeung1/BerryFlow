/*
 * ProjectModel.cpp
 *
 *  Created on: Aug 5, 2013
 *      Author: wyeung
 */

#include "ProjectModel.h"
#include <bb/data/JsonDataAccess>
#include <bb/cascades/ListView>

using namespace bb::cascades;
using namespace bb::data;


ProjectModel::ProjectModel(QObject *parent) : DataModel(parent) {
	this->initDatabase("./data/db.json");
}
ProjectModel::~ProjectModel() {
	bb::data::JsonDataAccess jda;
	jda.save(this->internalDB, "./data/db.json");
}
void ProjectModel::initDatabase(const QString& filename) {
    bb::data::JsonDataAccess jda;
    bool loaded = false;
    if(QFile::exists(filename)){
    	this->internalDB = jda.load(filename).value<QVariantList>();
    	if (jda.hasError()){
    		bb::data::DataAccessError error = jda.error();
    		qDebug() << error;
    	} else{
    		loaded = true;
    	}
    }

    if (loaded == false){
    	this->internalDB = jda.load("app/native/assets/data/db.json").value<QVariantList>();
    }
}


int ProjectModel::childCount(const QVariantList &indexPath) {
	if(indexPath.length() == 0) {
		return this->internalDB.length();
	} else if(indexPath.length() == 1) {
		QVariantMap map = this->internalDB.value(indexPath.value(0).toInt(NULL)).toMap();
		int count = map["steps"].toList().length();
		return count;
	}
	return 0;
}
bool ProjectModel::hasChildren(const QVariantList &indexPath) {
	if(indexPath.length() == 0) return true;
	else if(indexPath.length() == 1) return true;
	return false;
}
QString ProjectModel::itemType(const QVariantList &indexPath) {
	if (indexPath.length() == 1){
		QVariantMap project = this->internalDB.value(indexPath.value(0).toInt(NULL)).toMap();
		if (project["status"] == "archive"){
			if (!isFiltered(indexPath)){
				qDebug("filtered");
				return QString("filtered");
			}
			return QString("archive");
		}
		/* if the item does not begin with the filter, then it will return false.
		we want it to be a "filtered" type so it is filtered out of the list */
		if (!isFiltered(indexPath)){
			qDebug("filtered");
			return QString("filtered");
		}
		return QString("project");
	} else if (indexPath.length() == 2){
		return QString("step");
	} else {
		return QString::null;
	}
}
QVariant ProjectModel::data(const QVariantList &indexPath) {

	if(indexPath.length() == 1) {
		QVariantMap map = this->internalDB.value(indexPath.value(0).toInt(NULL)).toMap();
		map["start"] = map["start"].toDate();
		map["end"] = map["end"].toDate();
		return QVariant(map);
	}
	else if(indexPath.length() == 2) {
		QVariantMap map = this->internalDB.value(indexPath.value(0).toInt(NULL)).toMap();
		QVariantMap stepsMap = map["steps"].toList().value(indexPath.value(1).toInt(NULL)).toMap();
		stepsMap["no"] = indexPath.value(1).toInt(NULL) + 1;
		stepsMap["start"] = stepsMap["start"].toDate();
		stepsMap["due"] = stepsMap["due"].toDate();
		return QVariant(stepsMap);
	}
	return QVariant();
}


/*
 * Add a project to the data model
 * @param projectName the name of the project
 * @param projectStart the date that this project starts
 * @param projectEnd the date that this project is due
 * @param projectDescription A description of this project
 */
void ProjectModel::addProject(QString projectName, QDate projectStart,
							QDate projectEnd, QString projectDescription){
	QVariantMap newProject;
	QVariantList steps;
	//TODO: add the QVariantList for the members
	newProject["title"] = projectName;
	//TODO: add the project start and end dates to the calendar
	newProject["start"] = projectStart;
	newProject["end"] = projectEnd;
	newProject["description"] = projectDescription;
	newProject["steps"] = steps;
	//TODO: add the admin
	//TODO: add the creator (which will be the info for the owner of this blackberry

	newProject["status"] = "active"; // by default a project will be active


	this->internalDB.append(newProject);
	emit itemAdded(QVariantList() << this->internalDB.count()-1);
}

/*
 * updated the project at the given indexPath to the provided details
 */
void ProjectModel::editProject(const QVariantList &indexPath, QString projectName, QDate projectStart,
		QDate projectEnd, QString projectDescription){
	// get a reference to the project we are going to edit
	QVariantMap& project = (QVariantMap&) this->internalDB[indexPath.value(0).toInt(NULL)];
	project["title"] = projectName;
	project["start"] = projectStart;
	project["end"] = projectEnd;
	project["description"] = projectDescription;

	emit itemUpdated(indexPath); // emit signal that the item has been updated
}



void ProjectModel::addProjectStep(const QVariantList &indexPath, QString stepName,
									QDate stepStart, QDate stepDue, QVariantList members,
									QString stepDescription){

	// use a reference to the project in the database so that the values are directly manipulated
	QVariantMap& currentProject = (QVariantMap&) this->internalDB[indexPath.value(0).toInt(NULL)];
	QVariantList& projectSteps = (QVariantList&) currentProject["steps"];
	QVariantMap newStep;
	newStep["no"] = projectSteps.count() + 1;
	newStep["title"] = stepName;
	newStep["start"] = stepStart;

	newStep["due"] = stepDue;
	//TODO: finalize a way to handle members
	newStep["members"] = members;
	newStep["detail"] = stepDescription;
	projectSteps.append(newStep);
	emit itemAdded(QVariantList() << indexPath.value(0).toInt(NULL) << currentProject["steps"].toList().count() - 1);
}

void ProjectModel::editProjectStep(const QVariantList &indexPath, QString stepName, QDate stepStart,
			QDate stepEnd, QString stepDescription){
	QVariantMap& currentProject = (QVariantMap&) this->internalDB[indexPath.value(0).toInt(NULL)];
	QVariantList& projectSteps = (QVariantList&) currentProject["steps"];
	QVariantMap& step = (QVariantMap&) projectSteps[indexPath.value(1).toInt(NULL)];
	step["title"] = stepName;
	step["start"] = stepStart;
	step["due"] = stepEnd;
	step["detail"] = stepDescription;
	//TODO: handle the editing of assigned members
	emit itemUpdated(indexPath);
}

void ProjectModel::removeItems(const QVariantList &indexPaths) {
	// Loop through removing the highest item in the list first
	for(int i = indexPaths.count() - 1; i >= 0; i--) {
		QVariant indexPath = indexPaths.value(i);
		QVariantList indexPathList = indexPath.toList();
		if (indexPathList.count() == 1){
			int index = indexPathList.value(0).toInt(NULL);
			this->internalDB.removeAt(index);
		} else if (indexPathList.count() == 2){
			QVariantMap& currentProject = (QVariantMap&) this->internalDB[indexPathList.value(0).toInt(NULL)];
			QVariantList& projectSteps = (QVariantList&) currentProject["steps"];
			projectSteps.removeAt(indexPathList.value(1).toInt(NULL));
		}
		emit itemRemoved(indexPathList);
		emit itemsChanged(bb::cascades::DataModelChangeType::AddRemove);
	}
}

void ProjectModel::archiveItems(const QVariantList &indexPaths) {
	// Loop through removing the highest item in the list first
	for(int i = indexPaths.count() - 1; i >= 0; i--) {
		QVariant indexPath = indexPaths.value(i);
		QVariantList indexPathList = indexPath.toList();
		if(indexPathList.count() != 1) continue; // not a proper index path for this data type
		int index = indexPathList.value(0).toInt(NULL);
		QVariantMap& project = (QVariantMap&) this->internalDB[index];
		project["status"] = "archive";
		emit itemUpdated(indexPathList);
	}
}

void ProjectModel::setFilter(const QString filter){
	this->filter  = filter;
	emit itemsChanged(bb::cascades::DataModelChangeType::AddRemove);
}

bool ProjectModel::isFiltered(const QVariantList &indexPath){
	if (this->filter.isNull() || this->filter == ""){
		return true; // if the filter is empty, then we want everything to display
	} else if (indexPath.length() == 1){
		QVariantMap item = this->data(indexPath).toMap();
		qDebug() << item["title"].toString();
		qDebug() << this->filter;
		qDebug() << item["title"].toString().startsWith(this->filter, Qt::CaseInsensitive);
		return item["title"].toString().startsWith(this->filter, Qt::CaseInsensitive);
	} else {
		return false;
	}
}
void ProjectModel::unArchiveItems(const QVariantList &indexPaths) {
	// Loop through removing the highest item in the list first
	for(int i = indexPaths.count() - 1; i >= 0; i--) {
		QVariant indexPath = indexPaths.value(i);
		QVariantList indexPathList = indexPath.toList();
		if(indexPathList.count() != 1) continue; // not a proper index path for this data type
		int index = indexPathList.value(0).toInt(NULL);
		QVariantMap& project = (QVariantMap&) this->internalDB[index];
		project["status"] = "active";
		emit itemUpdated(indexPathList);
	}
}

