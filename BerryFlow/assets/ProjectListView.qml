import bb.cascades 1.0
import com.BerryFlow.ProjectData 1.0

NavigationPane{
    id: navPane
    
    Menu.definition: MenuDefinition {
        actions: [
            ActionItem {
                imageSource: "asset:///icons/ic_bbm.png"
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
    
	Page {
	    Container {
	        layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom

            }
       
            TextField {
            	hintText: "Filter Projects..."
            	leftPadding: 10
            	rightPadding: 10
            	preferredWidth: 768
            	topPadding: 3
            	verticalAlignment: VerticalAlignment.Top
            	horizontalAlignment: HorizontalAlignment.Center
            }
            
            Container {
                topPadding: 5
                leftPadding: 10
                rightPadding: 10
                horizontalAlignment: HorizontalAlignment.Fill
                layout: DockLayout {
                    
                }
                
                Label {
                    text: "Title"
                    horizontalAlignment: HorizontalAlignment.Left
                }
                Label {
                    text: "Due"
                    horizontalAlignment: HorizontalAlignment.Right
                }
            }
	        
             ListView {
                 id: listView
                 
                 dataModel: listModel
                 
                 leftPadding: 10
                 
                 
                 attachedObjects: [
                     ProjectModel{
                         id:listModel
                     }
                 ]
                 
                 horizontalAlignment: HorizontalAlignment.Center
                 
                 listItemComponents: [
                     ListItemComponent {
                         type: "project"
                         ProjectListItem {
                             name: ListItemData.title
                             description: ListItemData.description
                             duedate: ListItemData.end
                             startdate: ListItemData.start
                             status: ListItemData.status
                         }
                     },
                     ListItemComponent { // to hide the step items
                         type: "step"
                         Container {
                         }
                     },
                     ListItemComponent{
                         type: "archive"
                         Container {
                         }
                     }
                 ]
                 
                 multiSelectAction: MultiSelectActionItem {
                     multiSelectHandler: listView.multiSelectHandler
                 }
                 
                 multiSelectHandler {
                     status: "None Selected"
                     actions: [
                         DeleteActionItem {
                             onTriggered: {
                                 listView.dataModel.removeItems(listView.selectionList());
                             }
                         },
                         ActionItem {
                             title: "Archive Items"
                             imageSource: "asset:///icons/ic_entry.png"
                             onTriggered: {
                                 listView.dataModel.archiveItems(listView.selectionList());
                             }
                         }
                     ]
                 }
                 
                 
                 onTriggered: {
                     pushProjectDetailPage(indexPath)
                 }

                function pushProjectDetailPage(indexPath){
                     var p = projectDetailsPageDefinition.createObject();
                     var selectedItemData = dataModel.data(indexPath);
                     p.detailData = selectedItemData;
                     p.listViewModel = dataModel;
                     p.listViewIndexPath = indexPath;
                     console.log(dataModel.childCount(indexPath));
                     navPane.push(p);
                 }
                
                function pushForm(p){
                    navPane.push(p);
                }
             }
             
             
        }
	    actions: [
	        ActionItem {
	            imageSource: "asset:///icons/ic_add_folder.png"
            	title: "Add Project"
                onTriggered: {
                    addProjectSheet.open();
                }
                ActionBar.placement: ActionBarPlacement.OnBar
            },
	        ActionItem {
	            imageSource: "asset:///icons/ic_view_list.png"
            	title: "View Archive"
            	onTriggered: {
                    var p = projectArchiveList.createObject();
                    p.listModel = listModel
                    navPane.push(p);
                }
            },
	        ActionItem{
	            imageSource: "asset:///icons/ic_open_link.png"
	            title:"Invite to Download"
	            onTriggered: {
                	_inviteToDownload.sendInvite();
                }
	            enabled: {
                    _registrationHandler.allowed;
	            }
	        }
	    ]
	}
	
    attachedObjects: [
        // the page that will be pushed on when an item is selected
        ComponentDefinition {
            id: projectDetailsPageDefinition
            ProjectDetailPage {
                paneProperties: NavigationPaneProperties {
                    backButton: ActionItem {
                        onTriggered: {
                            navPane.pop();
                        }
                    }
                }
            }
        },
        AddProjectForm {
            id: addProjectSheet
            onAddNewProject: {
               	listModel.addProject(title, start, end, description);
               	addProjectSheet.title = "";
               	addProjectSheet.start = new Date();
               	addProjectSheet.end = new Date();
               	addProjectSheet.description = "";
            }
        },
        ComponentDefinition {
            id: projectArchiveList
            ArchiveListView {
                paneProperties: NavigationPaneProperties {
                    backButton: ActionItem {
                        onTriggered: {
                            navPane.pop();
                        }
                    }
                }
            }
        }
    ]
    
    onPopTransitionEnded: {
        page.destroy() // destroy the page object that was just popped off
    }
    
    
}