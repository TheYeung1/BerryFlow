/*
 * ProjectModel.h
 *
 *  Created on: Aug 5, 2013
 *      Author: wyeung
 */

#ifndef PROJECTMODEL_H_
#define PROJECTMODEL_H_

#include <QObject>
#include <bb/cascades/DataModel>
#include <bb/cascades/ArrayDataModel>


class ProjectModel : public bb::cascades::DataModel {
	Q_OBJECT

public:
	ProjectModel(QObject *parent = 0);
	virtual ~ProjectModel();

    Q_INVOKABLE virtual int childCount(const QVariantList &indexPath);
    Q_INVOKABLE virtual bool hasChildren(const QVariantList &indexPath);
    Q_INVOKABLE virtual QString itemType(const QVariantList &indexPath);
    Q_INVOKABLE virtual QVariant data(const QVariantList &indexPath);

	Q_INVOKABLE virtual void removeItems(const QVariantList &indexPaths);

	Q_INVOKABLE virtual void archiveItems(const QVariantList &indexPaths);
	Q_INVOKABLE virtual void unArchiveItems(const QVariantList &indexPaths);


	Q_INVOKABLE virtual void addProject(QString projectName, QDate projectStart,
			QDate projectEnd, QString projectDescription);

	Q_INVOKABLE virtual void addProjectStep(const QVariantList &indexPath, QString stepName,
			QDate stepStart, QDate stepDue, QVariantList members,
			QString stepDescription);

	Q_INVOKABLE virtual void editProject(const QVariantList &indexPath, QString projectName, QDate projectStart,
			QDate projectEnd, QString projectDescription);

	Q_INVOKABLE virtual void editProjectStep(const QVariantList &indexPath, QString stepName, QDate stepStart,
			QDate stepEnd, QString stepDescription);

	Q_INVOKABLE virtual void setFilter(const QString filter);

	Q_INVOKABLE virtual bool isFiltered(const QVariantList &indexPath);

private:
	QVariantList internalDB;
	QString filter;
	void initDatabase(const QString& filename);

};


#endif /* PROPERTYMODEL_H_ */
