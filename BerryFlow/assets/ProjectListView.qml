import bb.cascades 1.0
import com.BerryFlow.ProjectData 1.0

NavigationPane{
	Page {
	    Container {
	        layout: DockLayout {
             
             }
             ListView {
                 dataModel: listModel
                 
                 
                 attachedObjects: [
                     ProjectModel{
                         id:listModel
                     }
                 ]
                 
                 horizontalAlignment: HorizontalAlignment.Center
                 
                 listItemComponents: [
                     ListItemComponent {
                         ProjectListItem {
                             name: ListItemData.title
                             description: ListItemData.description
                             duedate: ListItemData.end
                         }
                     }
                 ]
             }
	    }
	}
}