var TB = TB || {};

TB.PostsModule = ( function() {
  
  var _getPostsContainer = () => {
    return $('#posts-container');
  };

  var _clearForm = () => {
    $('#new_post')[0].reset();
  };

  var _getPost = (id) => {
    return $(`[data-id="${id}"][data-type="Post"]`);
  };

  var addPost = (post) => {
    var $post = $(post);
    var $container = _getPostsContainer();
    $post.prependTo($container)
         .hide()
         .slideDown('fast');
    _clearForm();
  };

  var removePost = (id) => {
    var $post = _getPost(id);
    $post.slideUp('fast', () => { $(this).remove(); });
  };

  return {
    addPost: addPost,
    removePost: removePost
  };

})();
