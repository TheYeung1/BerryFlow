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


//void ProjectModel::addCity(QString cityName) {
//	QVariantMap map;
//	QVariantList predictions;
//	map["text"] = cityName;
//	map["temperature"] = 0;
//	map["time"] = "daytime";
//	map["condition"] = "clear";
//
//	QVariantMap day1; day1["day"] = "Tuesday"; day1["high"] = 0; day1["low"] = 0; day1["condition"] = "clear";
//	QVariantMap day2; day2["day"] = "Wednesday"; day2["high"] = 0; day2["low"] = 0; day2["condition"] = "clear";
//	QVariantMap day3; day3["day"] = "Thursday"; day3["high"] = 0; day3["low"] = 0; day3["condition"] = "clear";
//	QVariantMap day4; day4["day"] = "Friday"; day4["high"] = 0; day4["low"] = 0; day4["condition"] = "clear";
//	QVariantMap day5; day5["day"] = "Saturday"; day5["high"] = 0; day5["low"] = 0; day5["condition"] = "clear";
//	predictions.append(day1);
//	predictions.append(day2);
//	predictions.append(day3);
//	predictions.append(day4);
//	predictions.append(day5);
//
//	map["predictions"] = predictions;
//	this->internalDB.append(map);
//	emit itemAdded(QVariantList() << this->internalDB.count()-1);
//}

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


