import bb.cascades 1.0

ListView {
    dataModel: listModel
    attachedObjects: [
        ProjectModel{
            id:listModel
        }
    ]
    listItemComponents: [
        ListItemComponent {
            ProjectListItem {
                name: ListItemData.text
                description: ListItemData.description
                duedate: ListItemData.end
            }
        }
    ]
}
