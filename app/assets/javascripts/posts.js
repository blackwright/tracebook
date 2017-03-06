var TB = TB || {};

TB.PostsModule = ( function() {
  
  let _getPostsContainer = () => {
    return $('#posts-container');
  };

  let _clearForm = () => {
    $('#new_post')[0].reset();
  };

  let _getPost = (id) => {
    return $(`[data-id="${id}"][data-type="Post"]`);
  };

  let addPost = (post) => {
    let $post = $(post);
    let $container = _getPostsContainer();
    $post.prependTo($container)
         .hide()
         .slideDown('fast');
    _clearForm();
  };

  let removePost = (id) => {
    let $post = _getPost(id);
    $post.slideUp('fast', () => { $(this).remove(); });
  };

  return {
    addPost: addPost,
    removePost: removePost
  };

})();
