import bb.cascades 1.0
import com.BerryFlow.ProjectData 1.0

Page {
    id: detailPage
    
    property variant detailData: undefined //the details that describe this project
    
    property alias listViewModel: stepListView.dataModel
    property alias listViewIndexPath: stepListView.rootIndexPath
    
    
    Container {
    	layout: StackLayout {
         
         }
    	
    	Container {
        	Label {
             text: "You are here"
            }
        }
    	
    	// the list of steps
    	ListView {
    	    id: stepListView
            layout: StackListLayout {
                headerMode: ListHeaderMode.None
            }
        	listItemComponents: [
        	    ListItemComponent {
        	        type: "step"
                	Container {
                	    preferredHeight: 120

                        Divider {
                            topMargin: 0
                            bottomMargin: 0
                        }
                	    horizontalAlignment: HorizontalAlignment.Center
                	    layout: StackLayout {
                        	orientation: LayoutOrientation.LeftToRight 
                        }

                	    Label{
                	        text: ListItemData.no
                	        horizontalAlignment: HorizontalAlignment.Left
                	        verticalAlignment: VerticalAlignment.Center
                	        textStyle.fontSizeValue: 20
                	    }
                    	Container {
                        	layout: StackLayout {
                            	orientation: LayoutOrientation.TopToBottom
                            }
                        	Label{
                        	    text: ListItemData.title
                        	    horizontalAlignment: HorizontalAlignment.Left
                        	    verticalAlignment: VerticalAlignment.Top
                        	    textStyle.fontSizeValue: 14
                        	}
                        	Label{
                        	    text: ListItemData.detail
                        	    horizontalAlignment: HorizontalAlignment.Left
                        	    verticalAlignment: VerticalAlignment.Bottom
                        	    textStyle.fontSizeValue: 8
                        	    textStyle.color: Color.Gray
                        	}
                        }
                    }
                }
        	]
        }    
    }
}
