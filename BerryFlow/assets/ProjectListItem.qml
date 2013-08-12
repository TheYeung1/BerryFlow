import bb.cascades 1.0


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
            verticalAlignment: VerticalAlignment.Top
            textStyle.fontSizeValue: 14
        }
        Label {
            id: projectDescription
            text: "This is the project description"
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom
            textStyle.color: Color.Gray
            textStyle.fontSizeValue: 8
        }
    }
    
    Container {
        
        rightPadding: 5
        
        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Center

        Label {
            id: dueDate
            text: "7/9"
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Center
            textStyle.fontSizeValue: 14
        }
    }
}

