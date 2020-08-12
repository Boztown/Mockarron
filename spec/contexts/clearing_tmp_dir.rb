shared_context "clearing_tmp_dir", :a => :b do
  FileUtils.rm_rf("./spec/tmp", secure: true)
end

