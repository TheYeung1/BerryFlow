import bb.cascades 1.2

TabbedPane {
    Menu.definition: MenuDefinition {
        actions: [
            ActionItem {
                title: "Connect to BBM"
                onTriggered: {
                    !_registrationHandler.isRegistered();
                    _registrationHandler.registerApplication(); 
                } 
                enabled:{
                    !(_registrationHandler.allowed);
                }
            }
        ]
    }
    
    showTabsOnActionBar: true
    Tab { //First tab
        // Localized text with the dynamic translation and locale updates support
        title: qsTr("Active") + Retranslate.onLocaleOrLanguageChanged
        content: ProjectListView {
            
        }
    } //End of first tab
    Tab { //Second tab
        title: qsTr("Tab 2") + Retranslate.onLocaleOrLanguageChanged
        Page {
            Container {
                Label {
                    text: qsTr("Second tab") + Retranslate.onLocaleOrLanguageChanged
                }
            }
        }
    } //End of second tab
}
