{{#if pagination.next_url}}
	<a class="btn btn-default next-page" href="#" target="{{pagination.next_url}}">More</a><br>
{{/if}}

{{#data}}
<div class="thumbnail instagram-thumb">
    <img src="{{images.thumbnail.url}}" />
    <div class="caption">
    {{#first_n tags 2}}
          <span class="tag">{{ this }}</span>
    {{/first_n}}
    <p>{{caption.text}}</p>
    </div>
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