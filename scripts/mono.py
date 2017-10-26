import sys, os
import dendropy
import argparse
from dendropy import Tree
import copy,math,bisect
from sets import Set
from collections import Counter


def find_monophyly(prefix = "", tree_file = "", output_file = "", genotype_file = "/pedigree2/projects/namphuon/results/hbv/analyses/Accession_GI_Genotype.csv"):
  file = open(genotype_file, 'r')
  genotype_map = dict()
  for line in file:
    res = line.strip().split(',')
    if len(res[2]) > 1:
      continue
    genotype_map["gi_%s" % res[1]] = res[2]
  
  tree = Tree.get_from_path(tree_file,"newick",preserve_underscores=True)
  keep = [node.taxon.label for node in tree.leaf_nodes() if node.taxon.label in genotype_map]
  types = dict(zip(['A','B','C','D','E','F','G','H','I','J'],[dict(),dict(),dict(),dict(),dict(),dict(),dict(),dict(),dict()]))
  for (key,value) in genotype_map.items():
    if key not in keep:
      del genotype_map[key]
    else:
      for char in value:
        types[char][key] = char
  tree.retain_taxa_with_labels(keep)
  tree.is_rooted=False
  tree.deroot()
  tree.update_bipartitions()
  output = open(output_file, 'w')
  detailed = open(output_file+".detailed", 'w')  
  all_mismatches = dict()
  all_matches = dict()
  for type in types:
    lowest_mismatch = 50000    
    for node in tree.internal_nodes():
      match = 0
      mismatch = 0
      mismatches = dict()
      matches = dict()
      for leaf in node.leaf_nodes():
        if leaf.taxon.label in types[type]:
          match = match + 1
          matches[leaf.taxon.label] = type
        else:
          mismatch = mismatch + 1
          mismatches[leaf.taxon.label] = type
      if mismatch < lowest_mismatch and match == len(types[type]):
        lowest_mismatch = mismatch
        all_mismatches[type] = mismatches
        all_matches[type] = matches
    output.write("%s,%s,%d,%f\n" % (prefix,type,len(types[type]),len(types[type])*1.0/(lowest_mismatch+len(types[type]))))
    detailed.write("%s: %s\t%s\n" % (type, ",".join(all_matches[type].keys()), ",".join(all_mismatches[type].keys())))  
  output.close()
  detailed.close();

def parse_args():
  parser = argparse.ArgumentParser()
  parser.add_argument('-g', '--genotype_file', default="",
                      help='''genotype file''')                        
  parser.add_argument('-t', '--tree_file', default="",
                      help='''tree file''')                      
  parser.add_argument('-p', '--prefix', default="",
                      help='''prefix''')                        
  parser.add_argument('-o', '--output_file', default="",
                      help='''output''')
                      
  options = parser.parse_args()
  return options

options = parse_args()
find_monophyly(prefix = options.prefix, tree_file = options.tree_file, output_file = options.output_file, genotype_file = options.genotype_file)
