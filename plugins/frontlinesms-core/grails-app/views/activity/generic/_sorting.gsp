<div class="generic_sorting_tab">
	<h2><g:message code="activity.generic.sort.header"/></h2>
	<div class="info">
		<p><g:message code="activity.${activityType == 'autoreply' ? 'autoreply' : 'generic'}.sort.description"/></p>
	</div>
	<ul class="sorting-options">
		<li>
			<g:radio name="sorting" value="enabled" onchange="sortingOptionChanged()"
			checked="${!activityInstanceToEdit || ((activityInstanceToEdit?.keywords?.size() > 0) && (activityInstanceToEdit?.keywords[0].value != ''))}"/>
			<label class="sorting-option-label"><g:message code="activity.generic.enable.sorting"/></label>
			
		</li>
		<li>
			<g:radio name="sorting" value="global" onchange="sortingOptionChanged()"
			checked="${(activityInstanceToEdit?.keywords?.size() == 1) && (activityInstanceToEdit?.keywords[0].value == '')}"/>
			<label class="sorting-option-label"><g:message code="activity.generic.no.keywords.title"/></label>
			<div class="sorting-option">
				<label><g:message code="activity.generic.no.keywords.description"/></label>
			</div>
		</li>
		<li>
			<g:radio name="sorting" value="disabled" onchange="sortingOptionChanged()"
			checked="${(activityInstanceToEdit?.keywords?.size() == 0)}"/>
			<label class="sorting-option-label"><g:message code="activity.generic.disable.sorting"/></label>
			<div class="sorting-option">
				<label><g:message code="activity.${activityType == 'autoreply' ? 'autoreply' : 'generic'}.disable.sorting.description"/></label>
			</div>
		</li>
	</ul>
	<h2><g:message code="activity.generic.keywords.subtitle"/></h2>
	<div class="info"><label for="keywords"><g:message code="activity.generic.keywords.info"/></label></div>
	<div class="activity-keyword">
		<g:textField name="keywords" class="${!activityInstanceToEdit || ((activityInstanceToEdit?.keywords?.size() > 0) && (activityInstanceToEdit?.keywords[0].value != '')) ? 'required' : ''} validcommas sorting-generic-unique sorting-generic-no-spaces" value="${activityInstanceToEdit?.keywords? activityInstanceToEdit?.keywords*.value.join(',') : ''}" disabled="${activityInstanceToEdit && ((activityInstanceToEdit?.keywords?.size() == 0) || (activityInstanceToEdit?.keywords[0].value == ''))}"/>
	</div>
	<r:script>
	function sortingOptionChanged() {
		var state = $("input:radio[name=sorting]:checked").val();
		if (state == "enabled") {
			$("#keywords").attr("disabled", false);
			$("#keywords").addClass("required");
		}
		else {
			$("#keywords").attr("disabled", "disabled");
			$("#keywords").removeClass("required error");
			$(".error").hide();
		}
	}
	</r:script>
</div>
