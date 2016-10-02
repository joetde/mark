// ==UserScript==
// @name         Youtube custom libraries
// @namespace    joetde
// @version      0.1
// @description  custom js utilities for youtube
// @author       Me
// @match        https://www.youtube.com/*
// @grant        none
// ==/UserScript==

(function() {
    window.youtube = {};
    window.youtube.calls = [];
    var y = window.youtube;
    
    function register(callback) {
        y.calls.push(callback);
    }
    
    function replay() {
        y.calls.forEach(function(el) {
            el(false);
        });
    }
    
    function find_watched_badges() {
        return document.getElementsByClassName('watched-badge');
    }
    
    function get_parent_tag(element, tag_name) {
        if (!element || element.tagName.toLowerCase() == tag_name.toLowerCase()) {
            return element;
        } else {
            return get_parent_tag(element.parentElement, tag_name);
        }
    }
    
    function clear_watched(do_register = true) {
        if (do_register) { register(clear_watched); }
        var watched_badges = find_watched_badges();
        for (var i=watched_badges.length-1; i>=0; i--) {
            var watched_badge = watched_badges[i];
            if (watched_badge) {
                get_parent_tag(watched_badge, 'li').remove();
            }
        }
    }
    
    function filter_matching(regex, do_register = true) {
        if (do_register) { register(filter_matching.bind(null, regex)); }
        var lis = document.getElementsByTagName('li');
        for (var i=lis.length-1; i>=0; i--) {
            var li = lis[i];
            var li_child = li.getElementsByTagName('a')[1];
            if (li_child && li_child.text.match(regex)) {
                li.remove();
            }
        }
    }
    
    y.clear_watched = clear_watched;
    y.filter_matching = filter_matching;
    y.replay = replay;
    
    setInterval(replay, 200);
    
    //y.clear_watched();
    //y.filter_matching('Intro|Helping|Wayne|Credit|Date|Duet');
})();
