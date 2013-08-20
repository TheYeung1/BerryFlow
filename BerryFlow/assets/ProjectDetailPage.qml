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
    	    leftPadding: 14
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
        }
        	
    	Header {
        	title: "Start"
        }
    	Container {
        	leftPadding: 14
            Label {
                text: detailData.start
            }
        }
    	
        Header {
            title: "Due" 
        }
        Container {
            leftPadding: 14
            Label {
                text: detailData.end
            }
        }
        	
    	
    	Container {
        	Header {
             	title: "Steps"
            }
	    	// the list of steps
	    	ListView {
	    	    id: stepListView
	            
	            horizontalAlignment: horizontalAlignment.Center
	            leftPadding: 14
	            rightPadding: 5
	        	listItemComponents: [
	        	    ListItemComponent {
	        	        type: "step"
	        	        ProjectStepItem {
                      		step: ListItemData.no
                      		stepTitle: ListItemData.title
                      		stepDetail: ListItemData.detail
                      	}
	                }
	        	]
	        	
	        	onTriggered: {
              		pushStepDetailPage(indexPath);
              	}
	        
	            function pushStepDetailPage(indexPath){
	                var p = stepDetailPageDefinition.createObject();
	                var selectedItemData = dataModel.data(indexPath);
	                p.stepData = selectedItemData;
	                navPane.push(p);
	            }
	        }
	    	
	    }    
    }
    actions: [
        ActionItem {
            title: "Add Step"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                addStepForm.open();
            }
            
        },
        ActionItem {
            title: "Edit Details"
            onTriggered: {
                editProjectForm.open();
            }
        },
        ActionItem {
            title: "View Conversation"
            // TODO: Implement Me
        }
    ]
    
    attachedObjects: [
        ComponentDefinition {
            id: stepDetailPageDefinition
	        StepDetailPage {
	            paneProperties: NavigationPaneProperties {
	                backButton: ActionItem {
	                    onTriggered: {
	                        navPane.pop();
	                    }
	                }
	            }
	        }
	    },
        AddStepForm {
            id: addStepForm
            onAddNewStep: {
                listViewModel.addProjectStep(stepListView.rootIndexPath, stepName, stepStart, 
                    stepDue, stepMembers, stepDescription);
            }
        },
        AddProjectForm {
            id: editProjectForm
            mode: "edit"
            title: detailData.title
            start: detailData.start
            end: detailData.end
            description: detailData.description
            onEditProject: {
                listViewModel.editProject(stepListView.rootIndexPath, title, start, end, description);
                detailData = listViewModel.data(stepListView.rootIndexPath);
            }
        }
    ]
}
