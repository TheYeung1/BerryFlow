import bb.cascades 1.0

Sheet {
    id: addStepSheet
    property variant indexPath;
    
    
    signal addNewStep(variant indexPath, string stepName,
        			  date stepStart, date stepDue, variant stepMembers, string stepDescription);	
    
    Page {
        titleBar: TitleBar {
            title: "Add"
            dismissAction: ActionItem {
                title: "Cancel"
                onTriggered: {
                    addStepSheet.close(); 
                }
            }
            acceptAction: ActionItem {
                title: "Save" 
                enabled: Boolean(stepTitle.text)
                onTriggered: {
                    addStepSheet.close();
                    addStepSheet.addNewStep(indexPath,stepTitle.text,
                        stepStartDate.value,stepDueDate.value,
                        [],stepDescription.text);
                }
            }
        }
        
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
                value: { new Date(); }
            }
            
            DateTimePicker {
                id: stepDueDate
                title: "Due"
                value: {new Date(); }
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
