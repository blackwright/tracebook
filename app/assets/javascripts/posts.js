var TB = TB || {};

TB.PostsModule = ( function() {
  
  var _getPostsContainer = function() {
    return $('#posts-container');
  };

  var _clearForm = function() {
    $('#new_post')[0].reset();
  };

  var _getPost = function(id) {
    return $('[data-id="' + id + '"][data-type="Post"]');
  };

  var addPost = function(post) {
    var $post = $(post);
    var $container = _getPostsContainer();
    $post.prependTo($container)
         .hide()
         .slideDown('fast');
    _clearForm();
  };

  var removePost = function(id) {
    var $post = _getPost(id);
    $post.slideUp('fast', function() { $(this).remove(); });
  };

  return {
    addPost: addPost,
    removePost: removePost
  };

})();
