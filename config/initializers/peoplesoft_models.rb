PeoplesoftModels.default_schema_name = %w[development test staging].include?(Rails.env) ? "asr_warehouse" : "asr_warehouse_esup"
PeoplesoftModels.default_table_prefix = "cs_ps_"
