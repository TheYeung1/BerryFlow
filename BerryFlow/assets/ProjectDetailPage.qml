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
    	
    	attachedObjects: [
    	    TextStyleDefinition {
            	id: projectTitle
            	base: SystemDefaults.TextStyles.TitleText
            	fontSize: FontSize.Large 
            }
    	]
    	
    	Container {
    	    leftPadding: 10
        	Label {
	             text: detailData.title
	             textStyle.fontSizeValue: 20
	             horizontalAlignment: HorizontalAlignment.Fill
	             textStyle {
                     base: SystemDefaults.TextStyles.TitleText
                     fontSize: FontSize.Large 
	             }        	  
            }
        	Label {
            	text: detailData.description
            	horizontalAlignment: HorizontalAlignment.Fill 
            	multiline: true
            	textStyle {
            	    base: SystemDefaults.TextStyles.BodyText
            	    fontSize: FontSize.Medium
            	}
            }
        	Label {
            	text: "Start: " + detailData.start
            }
        	Label{
        	    text: "End: " + detailData.end
        	}
        	
        }
    	
    	Container {
        
	    	// the list of steps
	    	ListView {
	    	    id: stepListView
	            
	            horizontalAlignment: horizontalAlignment.Center
	            leftPadding: 10
	            rightPadding: 5
	        	listItemComponents: [
	        	    ListItemComponent {
	        	        type: "step"
	                	Container {
	                	    preferredHeight: 120
	                        Divider {
	                            topMargin: 0
	                            bottomMargin: 0
	                        }
	                        layout: DockLayout {
                             
                            }
	                	    
	                	    Label{
	                	        text: ListItemData.no
	                	        verticalAlignment: VerticalAlignment.Center 
	                	        horizontalAlignment: horizontalAlignment.Left
	                	        textStyle.fontSize: FontSize.Large
	                	    }
	                	    
	                    	Container {
	                    	    preferredHeight: 120
	                        	layout: StackLayout {
	                            	orientation: LayoutOrientation.TopToBottom
	                            }
	                        	
	                        	horizontalAlignment: HorizontalAlignment.Center
	                        	verticalAlignment: VerticalAlignment.Top
	                        	
	                        	Label{
	                        	    text: ListItemData.title
	
	                        	    textStyle.fontSize: FontSize.Medium
	                        	}
	                        	Label{
	                        	    text: ListItemData.detail
	                        	    textStyle.fontSize: FontSize.Small
	                        	    textStyle.color: Color.Gray
	                        	}
	                        }
	                    }
	                }
	        	]
	        }
	    }    
    }
}
