output "vpc_id_in_output" {
  value = module.vpc.vpc_id
}

output "eks_cluster_name_eks_tf" {
  value = module.eks.eks_cluster_name
}
