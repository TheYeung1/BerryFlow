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
	this->initDatabase("./data/sample.json");
}
ProjectModel::~ProjectModel() {
	bb::data::JsonDataAccess jda;
	jda.save(this->internalDB, "./data/sample.json");
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
    	this->internalDB = jda.load("app/native/assets/data/sample.json").value<QVariantList>();
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

		return QVariant(map);
	}
	else if(indexPath.length() == 2) {
		QVariantMap map = this->internalDB.value(indexPath.value(0).toInt(NULL)).toMap();
		QVariantMap stepsMap = map["steps"].toMap();
		return map["steps"].toList().value(indexPath.value(1).toInt(NULL));
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

void ProjectModel::addProjectStep(const QVariantList &indexPath, QString stepName,
									QDate stepStart, QDate stepDue, QVariantList members,
									QString stepDescription){
	QVariantMap currentProject = this->internalDB.value(indexPath.value(0).toInt(NULL)).toMap();
	QVariantMap newStep;
	QVariantList projectSteps = projectSteps = currentProject["steps"].toList();
	qDebug() << "Before";
	qDebug() << currentProject["steps"];
	newStep["no"] = projectSteps.count() + 1;
	newStep["title"] = stepName;
	newStep["start"] = stepStart;
	newStep["due"] = stepDue;
	//TODO: finalize a way to handle members
	newStep["members"] = members;
	newStep["detail"] = stepDescription;
	projectSteps.append(newStep);
	currentProject["steps"] = projectSteps;
	qDebug() << "After";
	qDebug() << currentProject["steps"];
	emit itemAdded(QVariantList() << indexPath.value(0).toInt(NULL) << currentProject["steps"].toList().count() - 1);

}

void ProjectModel::removeItems(const QVariantList &indexPaths) {
	// Loop through removing the highest item in the list first
	for(int i = indexPaths.count() - 1; i >= 0; i--) {
		QVariant indexPath = indexPaths.value(i);
		QVariantList indexPathList = indexPath.toList();
		if(indexPathList.count() != 1) continue; // not a proper index path for this data type
		int index = indexPathList.value(0).toInt(NULL);
		this->internalDB.removeAt(index);
		emit itemRemoved(indexPathList);
	}
}


