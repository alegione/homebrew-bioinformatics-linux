class Snippy < Formula
  desc "Rapid bacterial SNP calling and core genome alignments"
  homepage "https://github.com/tseemann/snippy"
  # doi ""
  # tag "bioinformatics"
  
  url "https://github.com/tseemann/snippy/archive/v3.2.tar.gz"
  sha256 "75377acc4687e21d46d773936389e3f0abd8441076d3c9acdd31be13b53352a8"

  head "https://github.com/tseemann/snippy.git"

  depends_on "Bio::Perl" => :perl
  depends_on "Time::Piece" => :perl

  depends_on "bwa"
  depends_on "htslib" # for 'bgzip'
  depends_on "freebayes"
  depends_on "parallel"
  depends_on "samtools"
  depends_on "vcflib"
  depends_on "vcftools"
  # latest version is buggy - stack overflow - so use bundled one
  # depends_on "snpeff"

  def install
    # rm "bin/snippy-make_tarball"
    prefix.install Dir["*"]
  end

  test do
    # terrible hack - need to fix return codes of other --help's
    ["","-core","-vcf_report","-vcf_to_tab","-vcf_filter"].each do |suffix|
      assert_match "Usage:", shell_output("#{bin}/snippy#{suffix} --fake 2>&1", 1)
    end
  end
end
