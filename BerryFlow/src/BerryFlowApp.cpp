#include "BerryFlowApp.hpp"


#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include "InviteToDownload.hpp"
#include "ProjectModel.h"
#include "RegistrationHandler.hpp"

using namespace bb::cascades;

BerryFlowApp::BerryFlowApp(bb::cascades::Application *app) :
        QObject(app)
{
    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);
    if(!QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()))) {
        // This is an abnormal situation! Something went wrong!
        // Add own code to recover here
        qWarning() << "Recovering from a failed connect()";
    }
    // initial load
    onSystemLanguageChanged();

    const QString uuid(QLatin1String("0165e3bf-42ca-45a1-99b2-0576608acaff"));
    RegistrationHandler *registrationHandler = new RegistrationHandler(uuid, app);

    // register the application at launch
    registrationHandler->registerApplication();

    InviteToDownload *inviteToDownload = new InviteToDownload(registrationHandler->context(), app);

    // Registering the model so that it can be accessed in QML
    qmlRegisterType<ProjectModel>("com.BerryFlow.ProjectData", 1, 0, "ProjectModel");

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    qml->setContextProperty("_registrationHandler", registrationHandler);

    // allow the invitation to download object to be accessible in QML
    qml->setContextProperty("_inviteToDownload", inviteToDownload);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    app->setScene(root);
}

void BerryFlowApp::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("BerryFlow_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}
