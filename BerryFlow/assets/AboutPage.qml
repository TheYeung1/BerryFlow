import bb.cascades 1.0

Page {
    id: aboutUsPage
	    Container {
	        layout: StackLayout {}
	        ImageView {
	            imageSource: "asset:///images/ProjectWorkFlowFeatured.png"
	            scalingMethod: ScalingMethod.AspectFit
	            verticalAlignment: VerticalAlignment.Top
	            horizontalAlignment: HorizontalAlignment.Center
	            preferredHeight: 500
	        }
	        ScrollView {
	            Container {
                    Label {
                        text: "About"
                        textStyle {
                            fontSize: FontSize.Large
                        }
                    }
                    Label {
                        multiline: true
                        text: "Project Worklow keeps track of your projects, not only when they start and end, but more importantly the work flow involved. Keep track of each step of the work flow for a project and the dates for each of them respectively."
                    }
                    Label {
                     	multiline: true
                     	text: "Project Workflow is a productivity app that allows users to write out and navigate through their projects, every step of the way. If you have any inquiries or concerns please send us a support email at yeung.winston@gmail.com."
                     	textStyle {
                     	    fontSize: FontSize.Small
                     	}   
                    }
	            }     
             }
	    }
}
