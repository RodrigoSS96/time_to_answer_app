module AdminsBackofficeHelper
  def translate_attributes(object = nil, method = nil)
    (object && method) ? object.model.human_attribute_name(method) : "ParamĂȘtros Incorretos"
  end
end
