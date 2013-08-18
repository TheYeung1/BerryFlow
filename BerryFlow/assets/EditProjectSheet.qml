import bb.cascades 1.0

Sheet{
    id: editSheet
    
    
    // a custom signal for adding a new project
    signal addNewProject(string title, date start, date end, string description)
    Page{
        
        
    	titleBar: TitleBar {
        	title: "Add"
        	dismissAction: ActionItem {
            	title: "Cancel"
            	onTriggered: {
                	editSheet.close(); 
                }
            }
        	acceptAction: ActionItem {
            	title: "Save" 
            	enabled: Boolean(projectTitle.text)
            	onTriggered: {
                	editSheet.close();
                	editSheet.addNewProject(projectTitle.text, projectStartDate.value, projectEndDate.value, projectDescription.text);
                }
            }
        }
    	
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
            }
        	
        	DateTimePicker {
        	    id: projectEndDate
            	title: "End"
            	value: { new Date(); } 
            	minimum: projectStartDate.value
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