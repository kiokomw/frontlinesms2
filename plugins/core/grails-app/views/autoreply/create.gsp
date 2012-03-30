<g:javascript src="characterSMS-count.js"/>

<div id="tabs" class="vertical-tabs">
	<div class="error-panel hide"><div id="error-icon"></div>Please fill in all required fields</div>
	<ol>
		<li><a class="tabs-1" href="#tabs-1">Enter keyword</a></li>
		<li><a class="tabs-2" href="#tabs-2">Enter message</a></li>
		<li><a class="tabs-3" href="#tabs-3">Confirm</a></li>
	</ol>

	<g:formRemote name="create_autoreply" url="[action:'save', controller:'autoreply', params:[ownerId:activityInstanceToEdit?.id ?: null]]" method="post"  onSuccess="launchMediumPopup('Autoreply created!', data, 'Ok', summaryRedirect)">
		<g:render template="../autoreply/keyword" plugin="core"/>
		<g:render template="../autoreply/message" plugin="core"/>
		<g:render template="../autoreply/confirm" plugin="core"/>
	</g:formRemote>
</div>
<g:javascript>
	function initializePopup() {
		$("#autoreplyText").trigger("keyup");
		
		$("#tabs-1").contentWidget({
			validate: function() {
				if (isElementEmpty("#tabs-1 #keyword")) {
					$("#tabs-1 #keyword").addClass("error");
					return false;
				}
				return true;
			}
		});
		
		$("#tabs-2").contentWidget({
			validate: function() {
				if (isElementEmpty("#tabs-2 #autoreplyText")) {
					$("#tabs-2 #autoreplyText").addClass("error");
					return false;
				}
				return true;
			}
		});
		
		$("#tabs").bind("tabsshow", function(event, ui) {
			updateConfirmationMessage();
		});
	}
	
	function updateConfirmationMessage() {
		var keyword = $('#keyword').val();
		var autoreplyText = $('#autoreplyText').val();

		$("#keyword-confirm").html('<pre>' + keyword  + '</pre>');
		$("#autoreply-confirm").html('<pre>' + autoreplyText  + '</pre>');
	}
		
	function summaryRedirect() {
		var ownerId = $(".summary #ownerId").val();
		$(this).dialog('close');
		window.location.replace(url_root + "message/autoreply/" + ownerId);
	}
</g:javascript>