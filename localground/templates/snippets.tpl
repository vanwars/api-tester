<div class="pager-container">
	{{#if previous}}
		<a class="btn btn-default paging" href="#" target="{{previous}}">Previous</a>
	{{/if}}
	{{#if next}}
		<a class="btn btn-default paging" href="#" target="{{next}}">Next</a>
	{{/if}}
</div>
<table class="table">
{{#results}}
	<tr>
      <td class="narrow"><span class="badge">{{level}}</span></td>
      <td>
      	<strong>{{ description }}</strong>
      	<br>
		<a href="{{example_url}}" target="_blank">View Example</a>
		<br>
		{{tagify tags}}
      </td>
	</tr>
{{/results}}
</table>

<script>
	var $tab = $('.tab-pane.active'); 
	$tab.find(".paging").click(function(e) {
		e.preventDefault();
	    $tab.find('input').val($(this).attr("target"));
	  	$tab.find('button').trigger('click');
	});
</script>