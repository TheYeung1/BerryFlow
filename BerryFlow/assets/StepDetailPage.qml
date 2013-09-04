import bb.cascades 1.0

Page {
    property variant stepData:undefined // the details that describe this step
    property variant listModel:undefined
    property variant stepIndexPath:undefined
    
    
    Container {
        
        
        Label{
            id: stepTitle
            text: stepData.title
            verticalAlignment: verticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Fill
            textStyle.fontSize: FontSize.Large
            textStyle.base: SystemDefaults.TextStyles.TitleText
        }
        
        Header {
            title: "Start"
        }
        Container {
        	leftPadding: 14    
	        Label{
	            id: stepStart
                text: Qt.formatDate(stepData.start, "yyyy-MM-dd");
	            horizontalAlignment: HorizontalAlignment.Left
	            textStyle.fontSize: FontSize.Medium
	            textStyle.base: SystemDefaults.TextStyles.BodyText
	        }	
        }
        Header {
            title: "Due"
        }
        Container {
            leftPadding: 14
	        Label{
	            id: stepDue
	            text: Qt.formatDate(stepData.due, "yyyy-MM-dd");
	            horizontalAlignment: HorizontalAlignment.Left
	            textStyle.fontSize: FontSize.Medium
	            textStyle.base: SystemDefaults.TextStyles.BodyText
	        }
        }
        
        Header {
            title: "Description"
        }
        Container {
            leftPadding: 14
            rightPadding: 14
	        Label {
	            id: stepDescription
	            text: stepData.detail
	            multiline: true 
	            horizontalAlignment: HorizontalAlignment.Fill
	            textStyle.fontSize: FontSize.Medium
	            textStyle.base: SystemDefaults.TextStyles.BodyText
	        }
        }
        
    }
    actions: [
        ActionItem {
            imageSource: "asset:///icons/ic_edit.png"
            title: "Edit"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                editStepForm.open()
            }
        }
    ]
    attachedObjects: [
        AddStepForm {
            id: editStepForm
            title: stepData.title
            start: stepData.start
            end: stepData.due
            description: stepData.detail
            mode: "Edit"
            onEditStep: {
                listModel.editProjectStep(stepIndexPath, title, start, end, description);
                stepData = listModel.data(stepIndexPath);
            }
        }
    ]
}
