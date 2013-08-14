import bb.cascades 1.0

Page {
    property variant stepData:undefined // the details that describe this step
    
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
	            text: stepData.start
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
	            text: stepData.due
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
        
        Header {
            title: "Assigned Members"
        }
        //TODO: have a list view display the members, figure out how to do this.
        
    }
    actions: [
        ActionItem {
            title: "Edit"
            ActionBar.placement: ActionBarPlacement.OnBar

        }
    ]
}
