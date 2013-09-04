import bb.cascades 1.0


// An item representing a step. Displayed in the ProjectDetailPage list of steps
Container {
    id: stepItem
    property alias step: stepNumber.text
    property alias stepTitle: stepTitle.text
    property alias stepDetail: stepDetail.text
    property date startdate
    property date duedate
    
    
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
        leftPadding: 50
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        
        
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
    
    contextActions: [
        ActionSet {
            ActionItem {
                title: "Edit"
                imageSource: "asset:///icons/ic_edit.png"
                onTriggered: {
                    var p = editStepForm.createObject();
                    p.open();
                }
            }
            
            DeleteActionItem {
                title: qsTr("Delete")
                onTriggered: {
                    stepItem.ListItem.view.dataModel.removeItems([stepItem.ListItem.indexPath]);
                }
            }
        }
    ]
    
    attachedObjects: [
        ComponentDefinition {
            id: editStepForm
            AddStepForm {
                title: stepTitle.text
                start: startdate
                end: duedate
                description: stepDetail.text
                mode: "Edit"
                onEditStep: {
                    stepItem.ListItem.view.dataModel.editProjectStep(stepItem.ListItem.indexPath, title, start, end, description)
                }
            }
        }
    ]
    
    function setHighlight (highlighted){
        if (highlighted){
            stepItem.opacity = 0.9;
            stepItem.background = Color.create("#0094D9");
        } else {
            stepItem.opacity = 1.0;
            stepItem.background = null ;
        }
    }
    
    ListItem.onActivationChanged: {
        setHighlight(ListItem.active);
    }
    
    ListItem.onSelectionChanged: {
        setHighlight(ListItem.selected);
    }
}