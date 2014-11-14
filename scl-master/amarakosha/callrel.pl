#!/usr/bin/perl

#  Copyright (C) 2006-2012 Shivaja Nair and Amba Kulkarni (ambapradeep@gmail.com)
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later
#  version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


require "../converters/convert.pl";

my %headers = ("syns","paryAyavAcI(\@Synset)","onto","paxArWawawwvavicAraH(\@Ontology)","holo","avayavI(\@Holonymy)","mero","avayavaH(\@Meronymy)","hyper","parAjAwi(\@Hypernymy)","hypo","aparAjAwi(\@Hyponymy)","janaka","janaka","janya","janya","pawi","pawi","pawnI","pawnI","svAmi","svAmi","sevaka","sevaka","vESiRtya","vESiRtyam","saMbanXa","sambanXiwa","vqwwi","AjIvikA","tree","");

my %dbm_fl_nm = ("syns","NULL","onto","onto","holo","avayavI","mero","avayava","hyper","parAjAwi","hypo","aparAjAwi","janaka","janaka","janya","janya","pawi","pawi","pawnI","pawnI","svAmi","svAmI","sevaka","sevaka","vESiRtya","vESiRtya","saMbanXa","sambanXi1","vqwwi","vqwwi");

$word = $ARGV[0];
$relation = $ARGV[1];
$encoding = $ARGV[2];
$out_encoding = $ARGV[3];
$pid = $ARGV[4];

      $word_wx=&convert($encoding,$pid,$word);
      chomp($word_wx);
      
      if($relation eq "tree"){
         system ("mkdir -p /tmp/AMARA_DOT");
         system("get_all_rel.pl $word_wx $out_encoding > /tmp/AMARA_DOT/graph$pid.dot");
         system("/usr/bin/dot /tmp/AMARA_DOT/graph$pid.dot -Tjpg -o /tmp/AMARA_DOT/graph$pid.jpg");
         print"<center><img src=\"http://localhost/htdocs/scl/amarakosha/DOT/graph$pid.jpg\" \/></center><br>";
      }else {
         my $str =  "relations.sh $dbm_fl_nm{$relation} '$headers{$relation}' $word_wx $out_encoding $pid";
         system($str);
      }
