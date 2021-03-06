<!-- <Snippet1> -->
<%@ Page Language="VB" 
    Inherits="System.Web.UI.MobileControls.MobilePage" %>
<%@ Register TagPrefix="mobile" 
    Namespace="System.Web.UI.MobileControls" 
    Assembly="System.Web.Mobile" %>
<%@ Import Namespace="System.Web.Mobile" %>

<script runat="server">
    Private Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not IsPostBack Then
            ' Create and bind an array of data
            Dim arr As New ArrayList()
            Dim i As Integer
            For i = 0 To 4
                arr.Add(i + 1)
            Next
            ObjectList1.DataSource = arr
            ObjectList1.DataBind()
        End If

        ' Create a Label and add it to the form
        Dim lab As _
            New System.Web.UI.MobileControls.Label()
        lab.Text = "Form.ID is ThirdForm"
        lab.Alignment = Alignment.Center
        ThirdForm.Form.Controls.Add(lab)

        ' Check the NoWrap capability
        Dim currentCapabilities As MobileCapabilities _
            = CType(Request.Browser, MobileCapabilities)
        If currentCapabilities.SupportsDivNoWrap Then
            FirstForm.Wrapping = Wrapping.NoWrap
        End If
    End Sub

    ' The command click event handler
    Private Sub OnCmdClick(ByVal sender As Object, ByVal e As EventArgs)
        ' Make sure there is a templated UI available
        ObjectList1.EnsureTemplatedUI()

        ' Find the label
        Dim lab As System.Web.UI.MobileControls.Label = _
            ObjectList1.Details.FindControl("DetLabel")

        ' Depending on the text in the Label, change view
        If lab.Text = "New Tasks" Then
            ObjectList1.ViewMode = ObjectListViewMode.List
        ElseIf lab.Text = "Task List" AndAlso _
            ObjectList1.ViewMode = ObjectListViewMode.Details Then

            lab.Text = "New Tasks"
        End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<body>
    <Mobile:Form id="FirstForm" runat="server">
        <mobile:Link ID="Link3" Runat="server" 
            NavigateUrl="#SecondForm">Second Form</mobile:Link>
        <mobile:Link ID="Link4" Runat="server" 
            NavigateUrl="#ThirdForm">Third Form</mobile:Link>
        <mobile:ObjectList id="ObjectList1" runat="server" 
            CommandStyle-StyleReference="subcommand" 
            LabelStyle-StyleReference="title" 
            DetailsCommandText="Details">
            <Command Name="Details" />
            <DeviceSpecific>
                <!-- No Filter, so chosen for all devices -->
                <Choice>
                    <ItemDetailsTemplate>
                        <mobile:Label id="DetLabel" runat="server" 
                            Text="Task List" Font-Bold="true" />
                        <mobile:Command id="Command1" 
                            runat="server" OnClick="OnCmdClick">
                            Command</mobile:Command>
                    </ItemDetailsTemplate>
                </Choice>
            </DeviceSpecific>
        </mobile:ObjectList>
    </mobile:Form>
    
    <mobile:Form ID="SecondForm" Runat="server">
        <mobile:Label ID="Label2" 
            Runat="server">The Second Form</mobile:Label>
        <mobile:Link ID="Link1" Runat="server" 
            NavigateUrl="#WelcomeForm">Back</mobile:Link>
    </mobile:Form>
    
    <mobile:Form ID="ThirdForm" Runat="server">
        <mobile:Label ID="Label3" Runat="server">
            The Third Form</mobile:Label>
        <mobile:Link ID="Link2" Runat="server" 
            NavigateUrl="#WelcomeForm">Back</mobile:Link>
    </mobile:Form>
</body>
</html>
<!-- </Snippet1> -->
