#define MESHFIX_WITH_EIGEN
#include "meshfix.h"

#include <igl/read_triangle_mesh.h>
#include <igl/write_triangle_mesh.h>
#include <iostream>

int main(int argc, char * argv[])
{
  // Load in libigl's (V,F) format
  Eigen::MatrixXd V,W;
  Eigen::MatrixXi F,G;
  if(argc <= 1)
  {
    std::cout<<R"(Usage:

    ./libigl_example [input](.obj|.ply|.stl|.off
)";
    return EXIT_FAILURE;
  }
  igl::read_triangle_mesh(argv[1],V,F);
  meshfix(V,F,W,G);
  // Write to OBJ
  igl::write_triangle_mesh("output.obj",W,G);
}
