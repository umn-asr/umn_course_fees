class CreateSynonyms < ActiveRecord::Migration[7.0]
  def change
    add_synonym(:warehouse_cs_ps_term_tbl, "asr_warehouse.cs_ps_term_tbl")
    add_synonym(:warehouse_cs_ps_institution_tbl, "asr_warehouse.cs_ps_institution_tbl")
    add_synonym(:warehouse_effective_courses, "asr_warehouse.effective_courses")
    add_synonym(:warehouse_dwsr_class, "asr_warehouse.ps_dwsr_class")
    add_synonym(:warehouse_cs_ps_subject_tbl, "asr_warehouse.cs_ps_subject_tbl")
    add_synonym(:warehouse_cs_ps_campus_tbl, "asr_warehouse.cs_ps_campus_tbl")
    add_synonym(:tfms_courses, "asr_tfms.courses")
    add_synonym(:tfms_fee_occurrences, "asr_tfms.fee_occurrences")
    add_synonym(:tfms_fees, "asr_tfms.fees")
    add_synonym(:tfms_fee_dimensions, "asr_tfms.fee_dimensions")
    add_synonym(:tfms_fee_categories, "asr_tfms.fee_categories")
    add_synonym(:tfms_rates, "asr_tfms.rates")
    add_synonym(:tfms_fiscal_years, "asr_tfms.fiscal_years")
    add_synonym(:tfms_revision_statuses, "asr_tfms.revision_statuses")
  end
end
