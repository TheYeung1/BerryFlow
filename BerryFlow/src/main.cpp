#include <bb/cascades/Application>

#include <QLocale>
#include <QTranslator>
#include "RegistrationHandler.hpp"
#include "BerryFlowApp.hpp"

#include <Qt/qdeclarativedebug.h>

using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    Application app(argc, argv);

    const QString uuid(QLatin1String("fcdc6a11-380a-41ad-8988-9ea608d22d24"));
    //TODO: connect the registered signal so that when registered, the ability to add new members is available.
    new RegistrationHandler(uuid, &app);

    // Create the Application UI object, this is where the main.qml file
    // is loaded and the application scene is set.
    new BerryFlowApp(&app);

    // Enter the application main event loop.
    return Application::exec();
}
