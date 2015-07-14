<ul class="nav nav-tabs" role="tablist">
{{#tabs}}
  	<li role="presentation">
  		<a href="#{{ slugify name }}" role="tab" data-toggle="tab">{{ name }}</a>
  	</li>
{{/tabs}}
</ul>
<div class="tab-content">
{{#tabs}}
  	<form role="tabpanel" class="form-horizontal tab-pane fade in" id="{{ slugify name }}">
  			<i class="fullscreen fa fa-expand pull-right"></i>
  			<div class="form-group">
	    	<label for="tag-search" class="col-sm-2 control-label">{{ name }} URL</label>
	    	<div class="col-sm-7">
	    		<input type="text" class="form-control" value="{{ url }}">
	  		</div>
	  		<div class="col-sm-2">
	  			<button class="btn btn-primary">Search</button>
	  		</div>
	  		<div class="col-sm-9">
	  			<p> 
	  				{{ help_text }} <a href="{{ reference_url }}" target="_blank">more info...</a>
	  			</p>
	  		</div>
	  	</div>
	  	<div class="row">
	  		<div class="col-sm-12 display-results"></div>
	  	</div>
	</form>
{{/tabs}}
</div>