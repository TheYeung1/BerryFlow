import bb.cascades 1.0


// An item representing a step. Displayed in the ProjectDetailPage list of steps
Container {
    property alias step: stepNumber.text
    property alias stepTitle: stepTitle.text
    property alias stepDetail: stepDetail.text
    
    preferredHeight: 120
    Divider {
        topMargin: 0
        bottomMargin: 0
    }
    layout: DockLayout {
    
    }
    
    Label{
        id: stepNumber
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
            id: stepTitle
            text: ListItemData.title
            
            textStyle.fontSize: FontSize.Medium
        }
        Label{
            id: stepDetail
            text: ListItemData.detail
            textStyle.fontSize: FontSize.Small
            textStyle.color: Color.Gray
        }
    }
}