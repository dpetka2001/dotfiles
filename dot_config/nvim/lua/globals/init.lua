-- function to return the spec of a plugin
SPEC = function(name)
  return require("lazy.core.config").spec.plugins[name]
end
