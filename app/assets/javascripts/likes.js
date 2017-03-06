var TB = TB || {};

TB.LikesModule = ( function() {

  var _getLikeContainer = function(parentId, parentType) {
    var $parent = $('[data-id="' + parentId + '"][data-type="' + parentType + '"]');
    return $parent.find('.like-container').first();
  };

  var _getFeedbackContainer = function(parentId, parentType) {
    var $parent = $('[data-id="' + parentId + '"][data-type="' + parentType + '"]');
    return $parent.find('.feedback-container').first();
  };

  var renderLikes = function(parentId, parentType, like, feedback) {
    var $likeContainer = _getLikeContainer(parentId, parentType);
    var $feedbackContainer = _getFeedbackContainer(parentId, parentType);
    var $like = $(like);
    var $feedback = $(feedback);
    $likeContainer.empty().append($like);
    $feedbackContainer.empty().append($feedback);
  };

  return {
    renderLikes: renderLikes
  };

})();
