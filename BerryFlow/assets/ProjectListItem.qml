import bb.cascades 1.0


// an item representing a project. Displayed in the ProjectListView
Container {
    property alias name: projectName.text
    property alias description: projectDescription.text
    property alias duedate: dueDate.text
    
    preferredHeight: 120

    
    horizontalAlignment: HorizontalAlignment.Fill
    
    Divider {
        topMargin: 0
        bottomMargin: 0
    }
    
    layout: DockLayout {
        
    }
    
    Container {
        horizontalAlignment: HorizontalAlignment.Left
        verticalAlignment: VerticalAlignment.Center
        
        leftPadding: 5
        
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: projectName
            text: "Project Name"
            horizontalAlignment: HorizontalAlignment.Left
            textStyle.fontSize: FontSize.Large
        }
        Label {
            id: projectDescription
            text: "This is the project description"
            horizontalAlignment: HorizontalAlignment.Left
            textStyle.color: Color.Gray
            textStyle.fontSize: FontSize.Small
        }
    }
    
    Container {
        
        rightPadding: 5
        
        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Top
        
        Label {
            id: dueDate
            text: "7/9"
            horizontalAlignment: HorizontalAlignment.Right
            textStyle.fontSize: FontSize.Small
        }
    }
}

