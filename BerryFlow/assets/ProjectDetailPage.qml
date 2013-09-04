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
                text: Qt.formatDate(detailData.start, "yyyy-MM-dd");
            }
        }
    	
        Header {
            title: "Due" 
            
        }
        Container {
            leftPadding: 14
            Label {
                text: Qt.formatDate(detailData.end, "yyyy-MM-dd");
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
	        	
                multiSelectAction: MultiSelectActionItem {
                    multiSelectHandler: stepListView.multiSelectHandler
                }
              
                multiSelectHandler {
                    status: "None selected"
                    actions: [
                        DeleteActionItem {
                            title: "Delete Selected"
                            onTriggered: {
                                stepListView.dataModel.removeItems(stepListView.selectionList());
                            }
                        }
                    ]
                }
                
                onSelectionChanged: {
                    if (selectionList().length > 1) {
                        multiSelectHandler.status = selectionList().length +
                        " items selected";
                    } else if (selectionList().length == 1) {
                        multiSelectHandler.status = "1 item selected";
                    } else {
                        multiSelectHandler.status = "None selected";
                    }
                }
	        
	            function pushStepDetailPage(indexPath){
	                var p = stepDetailPageDefinition.createObject();
	                var selectedItemData = dataModel.data(indexPath);
	                p.stepData = selectedItemData;
	                p.listModel = listViewModel;
	                p.stepIndexPath = indexPath;
	                navPane.push(p);
	            }
	            
                function pushForm(p){
                    navPane.push(p);
                }
	        }
	    	
	    }    
    }
    actions: [
        ActionItem {
            imageSource: "asset:///icons/ic_add.png"
            title: "Add Step"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                addStepForm.open();
            }
            
        },
        ActionItem {
            imageSource: "asset:///icons/ic_edit.png"
            title: "Edit Details"
            onTriggered: {
                editProjectForm.open();
            }
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
            mode: "Add";
            onAddNewStep: {
                listViewModel.addProjectStep(stepListView.rootIndexPath, stepName, stepStart, 
                    stepDue, stepMembers, stepDescription);
                addStepForm.title = "";
                addStepForm.start = new Date();
                addStepForm.end = new Date();
                addStepForm.description = "";
            }
        },
        AddProjectForm {
            id: editProjectForm
            mode: "Edit"
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
