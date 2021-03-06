vueKeepScroll = undefined
slice = [].slice
vueKeepScroll = install: (Vue) ->
  Vue.directive 'keep-scroll', bind: ->
    oldAttached = undefined
    @el.addEventListener 'scroll', (e) ->
      ele = undefined
      ele = e.target
      ele.setAttribute 'data-vuescrlpos', ele.scrollLeft + '-' + ele.scrollTop
    oldAttached = @vm.attached

    @vm.attached = ->
      args = undefined
      ele = undefined
      i = undefined
      len = undefined
      ref = undefined
      ref1 = undefined
      args = if 1 <= arguments.length then slice.call(arguments, 0) else []
      ref = @$el.querySelectorAll('[data-vuescrlpos]')
      if ref.length > 0
        i = 0
        len = ref.length
        while i < len
          ele = ref[i]
          ref1 = ele.getAttribute('data-vuescrlpos').split('-')
          ele.scrollLeft = ref1[0]
          ele.scrollTop = ref1[1]
          i++
      else if @$el.hasAttribute('data-vuescrlpos')
        ref1 = @$el.getAttribute('data-vuescrlpos').split('-')
        @$el.scrollLeft = ref1[0]
        @$el.scrollTop = ref1[1]
      if oldAttached != undefined then oldAttached.call.apply(oldAttached, [ this ].concat(slice.call(args))) else undefined
      return

    @vm.$on 'hook:attached', @vm.attached
    return
if typeof exports == 'object'
  module.exports = vueKeepScroll
else if typeof define == 'function' and define.amd
  define [], ->
    vueKeepScroll
else if window.Vue
  window.vueKeepScroll = vueKeepScroll
  Vue.use vueKeepScroll

# ---
# generated by js2coffee 2.1.0