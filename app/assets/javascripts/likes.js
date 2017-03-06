var TB = TB || {};

TB.LikesModule = ( function() {

  let _getLikeContainer = (parentId, parentType) => {
    let $parent = $(`[data-id="${parentId}"][data-type="${parentType}"]`);
    return $parent.find('.like-container').first();
  };

  let _getFeedbackContainer = (parentId, parentType) => {
    let $parent = $(`[data-id="${parentId}"][data-type="${parentType}"]`);
    return $parent.find('.feedback-container').first();
  };

  let renderLikes = (parentId, parentType, like, feedback) => {
    let $likeContainer = _getLikeContainer(parentId, parentType);
    let $feedbackContainer = _getFeedbackContainer(parentId, parentType);
    let $like = $(like);
    let $feedback = $(feedback);
    $likeContainer.empty().append($like);
    $feedbackContainer.empty().append($feedback);
  };

  return {
    renderLikes: renderLikes
  };

})();
