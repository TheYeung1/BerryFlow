import bb.cascades 1.0
import com.BerryFlow.ProjectData 1.0

NavigationPane{
    id: navPane
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
                         }
                     },
                     ListItemComponent { // to hide the step items
                         type: "step"
                         Container {
                         }
                     }
                 ]
                 
                 multiSelectHandler {
                     status: "None Selected"
                     actions: [
                         DeleteActionItem {
                             onTriggered: {
                                 listView.dataModel.removeItems(listView.selectionList());
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
             }
        }
	    actions: [
	        ActionItem {
            	title: "Add Project"
                onTriggered: {
                    addProjectSheet.open();
                }
            },
	        ActionItem {
            	title: "View Archive"
            	// TODO: Implement Me 
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
        EditProjectSheet {
            id: addProjectSheet
        }
    ]
    
    onPopTransitionEnded: {
        page.destroy() // destroy the page object that was just popped off
    }
}