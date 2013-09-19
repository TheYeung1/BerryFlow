import bb.cascades 1.0

Sheet{
    id: addProjectSheet
    
    
    // a custom signal for adding a new project
    signal addNewProject(string title, date start, date end, string description)
    
    // another custom signal for editing a project
    signal editProject(string title, date start, date end, string description);
    
    property variant indexPath;
    property variant mode : "Add"; // by default the mode will be add
    
    property alias title: projectTitle.text;
    property alias start: projectStartDate.value;
    property alias end: projectEndDate.value;
    property alias description: projectDescription.text;
    
    Page{
        
        
    	titleBar: TitleBar {
        	title: mode
        	dismissAction: ActionItem {
            	title: "Cancel"
            	onTriggered: {
                    addProjectSheet.close(); 
                }
            }
        	acceptAction: ActionItem {
            	title: "Save" 
            	enabled: Boolean(projectTitle.text)
            	onTriggered: {
                    addProjectSheet.close();
                    if (mode == "Add"){
                    	addProjectSheet.addNewProject(projectTitle.text, projectStartDate.value, projectEndDate.value, projectDescription.text);
                    } else{
                        addProjectSheet.editProject(projectTitle.text, projectStartDate.value, projectEndDate.value, projectDescription.text);
                    }
                }
            }
        }
    	ScrollView {
         
	    	Container {
	    	    topPadding: 5
	    	    leftPadding: 5
	    	    rightPadding: 5
	    	    
	        	TextField {
	        	    id: projectTitle
	            	hintText: "Project Title" 
	            	verticalAlignment: VerticalAlignment.Top
	            	horizontalAlignment: HorizontalAlignment.Fill
	            }
	        	
	        	DateTimePicker {
	        	    id: projectStartDate
	            	title: "Start"
	            	value: { new Date(); } 
	                mode: DateTimePickerMode.Date
	            }
	        	
	        	DateTimePicker {
	        	    id: projectEndDate
	            	title: "End"
	            	value: { new Date(); } 
	            	minimum: projectStartDate.value
	                mode: DateTimePickerMode.Date
	            }
	        	
	        	TextArea {
	        	    id: projectDescription
	            	hintText: "Description"
	            	horizontalAlignment: HorizontalAlignment.Fill 
	                preferredHeight: 450
	                maxHeight: 450
	            }
	        }
	    }
    	
    }
}