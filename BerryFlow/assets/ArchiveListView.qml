import bb.cascades 1.0
import com.BerryFlow.ProjectData 1.0

Page {
    property alias listModel: listView.dataModel
    
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
            
            dataModel: undefined
            
            leftPadding: 10
            
            horizontalAlignment: HorizontalAlignment.Center
            
            listItemComponents: [
                ListItemComponent {
                    type: "archive"
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
                },
                ListItemComponent { // to hide the step items
	                type: "project"
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
                    },
                    ActionItem{
                        title: "Unarchive"
                        //TODO: implement me
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
}