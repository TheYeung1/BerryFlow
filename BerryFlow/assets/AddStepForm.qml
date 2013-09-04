import bb.cascades 1.0

Sheet {
    id: addStepSheet
    property variant indexPath;
    property string mode: "Add"; // by default the mode will be to add
    
    signal addNewStep(string stepName,
        			  date stepStart, date stepDue, variant stepMembers, string stepDescription);	
    
    signal editStep(string stepName,
    				date stepStart, date stepDue, string stepDescription);

    
    property alias title: stepTitle.text
    property alias start: stepStartDate.value
    property alias end: stepDueDate.value
    property alias description: stepDescription.text

    Page {
        titleBar: TitleBar {
            title: mode
            dismissAction: ActionItem {
                imageSource: "asset:///icons/ic_cancel.png"
                title: "Cancel"
                onTriggered: {
                    addStepSheet.close(); 
                }
            }
            acceptAction: ActionItem {
                imageSource: "asset:///icons/ic_save.png"
                title: "Save" 
                enabled: Boolean(stepTitle.text)
                onTriggered: {
                    addStepSheet.close();
                    if (mode == "Add"){
	                    var A = [];
	                    addStepSheet.addNewStep(stepTitle.text,
	                        stepStartDate.value,stepDueDate.value,
	                        A,stepDescription.text);
                    } else {
                        addStepSheet.editStep(stepTitle.text,
                            stepStartDate.value, stepDueDate.value, stepDescription.text);
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
	                id: stepTitle
	                hintText: "Step Name"
	                verticalAlignment: VerticalAlignment.Top
	                horizontalAlignment: HorizontalAlignment.Fill
	            }
	            
	            DateTimePicker {
	                id: stepStartDate
	                title: "Start"
	                mode: DateTimePickerMode.Date
	                value: { new Date(); }
	            }
	            
	            DateTimePicker {
	                id: stepDueDate
	                title: "Due"
	                value: {new Date(); }
	                mode: DateTimePickerMode.Date
	                minimum: stepStartDate.value
	            }
	            
	            TextArea {
	                id: stepDescription
	                hintText: "Description"
	                horizontalAlignment: HorizontalAlignment.Fill
	                preferredHeight: 450
	                maxHeight: 450
	            }
	            
	            //TODO: add list here for members that can be added
	        }
	    }
    }
}
