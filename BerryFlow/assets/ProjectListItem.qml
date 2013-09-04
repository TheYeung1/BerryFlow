import bb.cascades 1.0


// an item representing a project. Displayed in the ProjectListView
Container {
    id: project
    property alias name: projectName.text
    property alias description: projectDescription.text
    property variant startdate
    property variant duedate
    property string status: "active"
    
    
    preferredHeight: 120

    
    horizontalAlignment: HorizontalAlignment.Fill
    
    Divider {
        topMargin: 0
        bottomMargin: 0
    }
    
    layout: DockLayout {
        
    }
    
    Container {
        horizontalAlignment: HorizontalAlignment.Left
        verticalAlignment: VerticalAlignment.Center
        
        leftPadding: 5
        
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: projectName
            text: "Project Name"
            horizontalAlignment: HorizontalAlignment.Left
            textStyle.fontSize: FontSize.Large
        }
        Label {
            id: projectDescription
            text: "This is the project description"
            horizontalAlignment: HorizontalAlignment.Left
            textStyle.color: Color.Gray
            textStyle.fontSize: FontSize.Small
        }
    }
    
    Container {
        
        rightPadding: 5
        
        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Top
        
        Label {
            id: dueDate
            text: Qt.formatDate(duedate, "yyyy-MM-dd");
            horizontalAlignment: HorizontalAlignment.Right
            textStyle.fontSize: FontSize.Small
        }
    }
    
    contextActions: [
        ActionSet {
            ActionItem {
                title: qsTr("Edit")
                imageSource: "asset:///icons/ic_edit.png"
                
                onTriggered: {
                    var p = editProjectSheet.createObject();
                    p.open();
                }
                
                enabled: {(status == "active")}
            }
            
            ActionItem {
                title: setArchiveActionTitle(status)
                imageSource: "asset:///icons/ic_entry.png"
                onTriggered: {
                    if (status == "active"){
                    	project.ListItem.view.dataModel.archiveItems([project.ListItem.indexPath]);
                    } else if (status == "archive"){
                        project.ListItem.view.dataModel.unArchiveItems([project.ListItem.indexPath]);
                    }
                }
            }
            
	        DeleteActionItem{
	            title: qsTr("Delete") + Retranslate.onLanguageChanged
	            
	            onTriggered: {
                    project.ListItem.view.dataModel.removeItems([project.ListItem.indexPath]); 
                }
	        }
	        
	        MultiSelectActionItem {
	            multiSelectHandler: project.ListItem.view.multiSelectHandler
	            onTriggered: {
	                multiSelectHandler.active
	            }
	        }
         }
    ]
    
    function setArchiveActionTitle(status){
        if (status == "active"){
            return "Archive";
        } else if(status == "archive"){
            return "Unarchive"
        } else {
            return ""
        }
    }
    
    function setHighlight (highlighted){
        if (highlighted){
            project.opacity = 0.9;
            project.background = Color.create("#0094D9");
        } else {
            project.opacity = 1.0;
            project.background = null ;
        }
    }
    
    ListItem.onActivationChanged: {
        setHighlight(ListItem.active);
    }
    
    ListItem.onSelectionChanged: {
        setHighlight(ListItem.selected);
    }
    
    attachedObjects: [
        ComponentDefinition {
            id: editProjectSheet
	        AddProjectForm {
	            title: projectName.text
	            start: startdate
	            end: duedate
	            description: projectDescription.text
	            mode: "Edit"
	            onEditProject: {
                    project.ListItem.view.dataModel.editProject(project.ListItem.indexPath, title, start, end, description);
	            } 
	        }
        }
    ]
}

