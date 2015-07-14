{{#if pagination.next_url}}
	<a class="btn btn-default next-page" href="#" target="{{pagination.next_url}}">More</a><br>
{{/if}}

{{#data}}
<div class="col-md-2 article-img">
    <a href="#">
        <img src="{{images.thumbnail.url}}" />
    </a>
   <div class="article-overlay"></div>
</div>
{{/data}}

<script>
	var $tab = $('.tab-pane.active'); 
	$tab.find(".next-page").click(function(e) {
		e.preventDefault();
	    $tab.find('input').val($(this).attr("target"));
	  	$tab.find('button').trigger('click');
	});
</script>