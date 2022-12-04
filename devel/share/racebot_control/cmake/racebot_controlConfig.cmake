# generated from catkin/cmake/template/pkgConfig.cmake.in

# append elements to a list and remove existing duplicates from the list
# copied from catkin/cmake/list_append_deduplicate.cmake to keep pkgConfig
# self contained
macro(_list_append_deduplicate listname)
  if(NOT "${ARGN}" STREQUAL "")
    if(${listname})
      list(REMOVE_ITEM ${listname} ${ARGN})
    endif()
    list(APPEND ${listname} ${ARGN})
  endif()
endmacro()

# append elements to a list if they are not already in the list
# copied from catkin/cmake/list_append_unique.cmake to keep pkgConfig
# self contained
macro(_list_append_unique listname)
  foreach(_item ${ARGN})
    list(FIND ${listname} ${_item} _index)
    if(_index EQUAL -1)
      list(APPEND ${listname} ${_item})
    endif()
  endforeach()
endmacro()

# pack a list of libraries with optional build configuration keywords
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_pack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  set(_argn ${ARGN})
  list(LENGTH _argn _count)
  set(_index 0)
  while(${_index} LESS ${_count})
    list(GET _argn ${_index} lib)
    if("${lib}" MATCHES "^(debug|optimized|general)$")
      math(EXPR _index "${_index} + 1")
      if(${_index} EQUAL ${_count})
        message(FATAL_ERROR "_pack_libraries_with_build_configuration() the list of libraries '${ARGN}' ends with '${lib}' which is a build configuration keyword and must be followed by a library")
      endif()
      list(GET _argn ${_index} library)
      list(APPEND ${VAR} "${lib}${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}${library}")
    else()
      list(APPEND ${VAR} "${lib}")
    endif()
    math(EXPR _index "${_index} + 1")
  endwhile()
endmacro()

# unpack a list of libraries with optional build configuration keyword prefixes
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_unpack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  foreach(lib ${ARGN})
    string(REGEX REPLACE "^(debug|optimized|general)${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}(.+)$" "\\1;\\2" lib "${lib}")
    list(APPEND ${VAR} "${lib}")
  endforeach()
endmacro()


if(racebot_control_CONFIG_INCLUDED)
  return()
endif()
set(racebot_control_CONFIG_INCLUDED TRUE)

# set variables for source/devel/install prefixes
if("TRUE" STREQUAL "TRUE")
  set(racebot_control_SOURCE_PREFIX /home/lc/urdf_ws/src/racebot_control)
  set(racebot_control_DEVEL_PREFIX /home/lc/urdf_ws/devel)
  set(racebot_control_INSTALL_PREFIX "")
  set(racebot_control_PREFIX ${racebot_control_DEVEL_PREFIX})
else()
  set(racebot_control_SOURCE_PREFIX "")
  set(racebot_control_DEVEL_PREFIX "")
  set(racebot_control_INSTALL_PREFIX /home/lc/urdf_ws/install)
  set(racebot_control_PREFIX ${racebot_control_INSTALL_PREFIX})
endif()

# warn when using a deprecated package
if(NOT "" STREQUAL "")
  set(_msg "WARNING: package 'racebot_control' is deprecated")
  # append custom deprecation text if available
  if(NOT "" STREQUAL "TRUE")
    set(_msg "${_msg} ()")
  endif()
  message("${_msg}")
endif()

# flag project as catkin-based to distinguish if a find_package()-ed project is a catkin project
set(racebot_control_FOUND_CATKIN_PROJECT TRUE)

if(NOT " " STREQUAL " ")
  set(racebot_control_INCLUDE_DIRS "")
  set(_include_dirs "")
  if(NOT " " STREQUAL " ")
    set(_report "Check the issue tracker '' and consider creating a ticket if the problem has not been reported yet.")
  elseif(NOT " " STREQUAL " ")
    set(_report "Check the website '' for information and consider reporting the problem.")
  else()
    set(_report "Report the problem to the maintainer 'lc <lc@todo.todo>' and request to fix the problem.")
  endif()
  foreach(idir ${_include_dirs})
    if(IS_ABSOLUTE ${idir} AND IS_DIRECTORY ${idir})
      set(include ${idir})
    elseif("${idir} " STREQUAL "include ")
      get_filename_component(include "${racebot_control_DIR}/../../../include" ABSOLUTE)
      if(NOT IS_DIRECTORY ${include})
        message(FATAL_ERROR "Project 'racebot_control' specifies '${idir}' as an include dir, which is not found.  It does not exist in '${include}'.  ${_report}")
      endif()
    else()
      message(FATAL_ERROR "Project 'racebot_control' specifies '${idir}' as an include dir, which is not found.  It does neither exist as an absolute directory nor in '/home/lc/urdf_ws/src/racebot_control/${idir}'.  ${_report}")
    endif()
    _list_append_unique(racebot_control_INCLUDE_DIRS ${include})
  endforeach()
endif()

set(libraries "")
foreach(library ${libraries})
  # keep build configuration keywords, target names and absolute libraries as-is
  if("${library}" MATCHES "^(debug|optimized|general)$")
    list(APPEND racebot_control_LIBRARIES ${library})
  elseif(${library} MATCHES "^-l")
    list(APPEND racebot_control_LIBRARIES ${library})
  elseif(${library} MATCHES "^-")
    # This is a linker flag/option (like -pthread)
    # There's no standard variable for these, so create an interface library to hold it
    if(NOT racebot_control_NUM_DUMMY_TARGETS)
      set(racebot_control_NUM_DUMMY_TARGETS 0)
    endif()
    # Make sure the target name is unique
    set(interface_target_name "catkin::racebot_control::wrapped-linker-option${racebot_control_NUM_DUMMY_TARGETS}")
    while(TARGET "${interface_target_name}")
      math(EXPR racebot_control_NUM_DUMMY_TARGETS "${racebot_control_NUM_DUMMY_TARGETS}+1")
      set(interface_target_name "catkin::racebot_control::wrapped-linker-option${racebot_control_NUM_DUMMY_TARGETS}")
    endwhile()
    add_library("${interface_target_name}" INTERFACE IMPORTED)
    if("${CMAKE_VERSION}" VERSION_LESS "3.13.0")
      set_property(
        TARGET
        "${interface_target_name}"
        APPEND PROPERTY
        INTERFACE_LINK_LIBRARIES "${library}")
    else()
      target_link_options("${interface_target_name}" INTERFACE "${library}")
    endif()
    list(APPEND racebot_control_LIBRARIES "${interface_target_name}")
  elseif(TARGET ${library})
    list(APPEND racebot_control_LIBRARIES ${library})
  elseif(IS_ABSOLUTE ${library})
    list(APPEND racebot_control_LIBRARIES ${library})
  else()
    set(lib_path "")
    set(lib "${library}-NOTFOUND")
    # since the path where the library is found is returned we have to iterate over the paths manually
    foreach(path /home/lc/urdf_ws/devel/lib;/home/lc/autoware.ai/install/ymc/lib;/home/lc/autoware.ai/install/xsens_driver/lib;/home/lc/autoware.ai/install/lattice_planner/lib;/home/lc/autoware.ai/install/waypoint_planner/lib;/home/lc/autoware.ai/install/waypoint_maker/lib;/home/lc/autoware.ai/install/way_planner/lib;/home/lc/autoware.ai/install/op_utilities/lib;/home/lc/autoware.ai/install/op_simulation_package/lib;/home/lc/autoware.ai/install/op_local_planner/lib;/home/lc/autoware.ai/install/op_global_planner/lib;/home/lc/autoware.ai/install/lidar_kf_contour_track/lib;/home/lc/autoware.ai/install/op_ros_helpers/lib;/home/lc/autoware.ai/install/lane_planner/lib;/home/lc/autoware.ai/install/ff_waypoint_follower/lib;/home/lc/autoware.ai/install/dp_planner/lib;/home/lc/autoware.ai/install/waypoint_follower/lib;/home/lc/autoware.ai/install/vlg22c_cam/lib;/home/lc/autoware.ai/install/vision_ssd_detect/lib;/home/lc/autoware.ai/install/vision_segment_enet_detect/lib;/home/lc/autoware.ai/install/vision_lane_detect/lib;/home/lc/autoware.ai/install/vision_darknet_detect/lib;/home/lc/autoware.ai/install/vision_beyond_track/lib;/home/lc/autoware.ai/install/vehicle_socket/lib;/home/lc/autoware.ai/install/vehicle_model/lib;/home/lc/autoware.ai/install/vehicle_gazebo_simulation_launcher/lib;/home/lc/autoware.ai/install/vehicle_gazebo_simulation_interface/lib;/home/lc/autoware.ai/install/vehicle_description/lib;/home/lc/autoware.ai/install/trafficlight_recognizer/lib;/home/lc/autoware.ai/install/op_simu/lib;/home/lc/autoware.ai/install/op_planner/lib;/home/lc/autoware.ai/install/op_utility/lib;/home/lc/autoware.ai/install/lidar_euclidean_cluster_detect/lib;/home/lc/autoware.ai/install/vector_map_server/lib;/home/lc/autoware.ai/install/road_occupancy_processor/lib;/home/lc/autoware.ai/install/costmap_generator/lib;/home/lc/autoware.ai/install/object_map/lib;/home/lc/autoware.ai/install/naive_motion_predict/lib;/home/lc/autoware.ai/install/map_file/lib;/home/lc/autoware.ai/install/libvectormap/lib;/home/lc/autoware.ai/install/imm_ukf_pda_track/lib;/home/lc/autoware.ai/install/decision_maker/lib;/home/lc/autoware.ai/install/vector_map/lib;/home/lc/autoware.ai/install/vector_map_msgs/lib;/home/lc/autoware.ai/install/vectacam/lib;/home/lc/autoware.ai/install/udon_socket/lib;/home/lc/autoware.ai/install/twist_generator/lib;/home/lc/autoware.ai/install/tablet_socket/lib;/home/lc/autoware.ai/install/runtime_manager/lib;/home/lc/autoware.ai/install/mqtt_socket/lib;/home/lc/autoware.ai/install/tablet_socket_msgs/lib;/home/lc/autoware.ai/install/state_machine_lib/lib;/home/lc/autoware.ai/install/sound_player/lib;/home/lc/autoware.ai/install/sick_lms5xx/lib;/home/lc/autoware.ai/install/sick_ldmrs_tools/lib;/home/lc/autoware.ai/install/sick_ldmrs_driver/lib;/home/lc/autoware.ai/install/sick_ldmrs_msgs/lib;/home/lc/autoware.ai/install/sick_ldmrs_description/lib;/home/lc/autoware.ai/install/points2image/lib;/home/lc/autoware.ai/install/rosinterface/lib;/home/lc/autoware.ai/install/rosbag_controller/lib;/home/lc/autoware.ai/install/roi_object_filter/lib;/home/lc/autoware.ai/install/range_vision_fusion/lib;/home/lc/autoware.ai/install/pos_db/lib;/home/lc/autoware.ai/install/points_preprocessor/lib;/home/lc/autoware.ai/install/points_downsampler/lib;/home/lc/autoware.ai/install/pixel_cloud_fusion/lib;/home/lc/autoware.ai/install/lidar_localizer/lib;/home/lc/autoware.ai/install/pcl_omp_registration/lib;/home/lc/autoware.ai/install/pc2_downsampler/lib;/home/lc/autoware.ai/install/oculus_socket/lib;/home/lc/autoware.ai/install/obj_db/lib;/home/lc/autoware.ai/install/nmea_navsat/lib;/home/lc/autoware.ai/install/ndt_tku/lib;/home/lc/autoware.ai/install/ndt_cpu/lib;/home/lc/autoware.ai/install/multi_lidar_calibrator/lib;/home/lc/autoware.ai/install/microstrain_driver/lib;/home/lc/autoware.ai/install/memsic_imu/lib;/home/lc/autoware.ai/install/marker_downsampler/lib;/home/lc/autoware.ai/install/map_tools/lib;/home/lc/autoware.ai/install/map_tf_generator/lib;/home/lc/autoware.ai/install/log_tools/lib;/home/lc/autoware.ai/install/lidar_shape_estimation/lib;/home/lc/autoware.ai/install/lidar_point_pillars/lib;/home/lc/autoware.ai/install/lidar_naive_l_shape_detect/lib;/home/lc/autoware.ai/install/lidar_fake_perception/lib;/home/lc/autoware.ai/install/lidar_apollo_cnn_seg_detect/lib;/home/lc/autoware.ai/install/lgsvl_simulator_bridge/lib;/home/lc/autoware.ai/install/kvaser/lib;/home/lc/autoware.ai/install/kitti_launch/lib;/home/lc/autoware.ai/install/kitti_player/lib;/home/lc/autoware.ai/install/kitti_box_publisher/lib;/home/lc/autoware.ai/install/javad_navsat_driver/lib;/home/lc/autoware.ai/install/integrated_viewer/lib;/home/lc/autoware.ai/install/image_processor/lib;/home/lc/autoware.ai/install/hokuyo/lib;/home/lc/autoware.ai/install/graph_tools/lib;/home/lc/autoware.ai/install/gnss_localizer/lib;/home/lc/autoware.ai/install/gnss/lib;/home/lc/autoware.ai/install/glviewer/lib;/home/lc/autoware.ai/install/gazebo_world_description/lib;/home/lc/autoware.ai/install/gazebo_imu_description/lib;/home/lc/autoware.ai/install/gazebo_camera_description/lib;/home/lc/autoware.ai/install/garmin/lib;/home/lc/autoware.ai/install/freespace_planner/lib;/home/lc/autoware.ai/install/fastvirtualscan/lib;/home/lc/autoware.ai/install/ekf_localizer/lib;/home/lc/autoware.ai/install/ds4_msgs/lib;/home/lc/autoware.ai/install/ds4_driver/lib;/home/lc/autoware.ai/install/detected_objects_visualizer/lib;/home/lc/autoware.ai/install/decision_maker_panel/lib;/home/lc/autoware.ai/install/data_preprocessor/lib;/home/lc/autoware.ai/install/custom_msgs/lib;/home/lc/autoware.ai/install/calibration_publisher/lib;/home/lc/autoware.ai/install/autoware_health_checker/lib;/home/lc/autoware.ai/install/autoware_system_msgs/lib;/home/lc/autoware.ai/install/autoware_rviz_plugins/lib;/home/lc/autoware.ai/install/autoware_quickstart_examples/lib;/home/lc/autoware.ai/install/autoware_pointgrey_drivers/lib;/home/lc/autoware.ai/install/autoware_driveworks_interface/lib;/home/lc/autoware.ai/install/autoware_connector/lib;/home/lc/autoware.ai/install/autoware_camera_lidar_calibrator/lib;/home/lc/autoware.ai/install/astar_search/lib;/home/lc/autoware.ai/install/as/lib;/home/lc/autoware.ai/install/amathutils_lib/lib;/home/lc/autoware.ai/install/autoware_msgs/lib;/home/lc/autoware.ai/install/autoware_map_msgs/lib;/home/lc/autoware.ai/install/autoware_launcher_rviz/lib;/home/lc/autoware.ai/install/autoware_launcher/lib;/home/lc/autoware.ai/install/autoware_external_msgs/lib;/home/lc/autoware.ai/install/autoware_driveworks_gmsl_interface/lib;/home/lc/autoware.ai/install/autoware_config_msgs/lib;/home/lc/autoware.ai/install/autoware_can_msgs/lib;/home/lc/autoware.ai/install/autoware_build_flags/lib;/home/lc/autoware.ai/install/autoware_bag_tools/lib;/home/lc/autoware.ai/install/adi_driver/lib;/home/lc/ws_manager/devel/lib;/opt/ros/melodic/lib;/home/lc/demo01_ws/devel/lib;/home/lc/cv_bridge_ws/install/lib;/home/lc/urdf_ws/devel/lib;/home/lc/cartographer_ws/install_isolated/lib;/home/lc/catkin_ws/devel/lib)
      find_library(lib ${library}
        PATHS ${path}
        NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
      if(lib)
        set(lib_path ${path})
        break()
      endif()
    endforeach()
    if(lib)
      _list_append_unique(racebot_control_LIBRARY_DIRS ${lib_path})
      list(APPEND racebot_control_LIBRARIES ${lib})
    else()
      # as a fall back for non-catkin libraries try to search globally
      find_library(lib ${library})
      if(NOT lib)
        message(FATAL_ERROR "Project '${PROJECT_NAME}' tried to find library '${library}'.  The library is neither a target nor built/installed properly.  Did you compile project 'racebot_control'?  Did you find_package() it before the subdirectory containing its code is included?")
      endif()
      list(APPEND racebot_control_LIBRARIES ${lib})
    endif()
  endif()
endforeach()

set(racebot_control_EXPORTED_TARGETS "")
# create dummy targets for exported code generation targets to make life of users easier
foreach(t ${racebot_control_EXPORTED_TARGETS})
  if(NOT TARGET ${t})
    add_custom_target(${t})
  endif()
endforeach()

set(depends "")
foreach(depend ${depends})
  string(REPLACE " " ";" depend_list ${depend})
  # the package name of the dependency must be kept in a unique variable so that it is not overwritten in recursive calls
  list(GET depend_list 0 racebot_control_dep)
  list(LENGTH depend_list count)
  if(${count} EQUAL 1)
    # simple dependencies must only be find_package()-ed once
    if(NOT ${racebot_control_dep}_FOUND)
      find_package(${racebot_control_dep} REQUIRED NO_MODULE)
    endif()
  else()
    # dependencies with components must be find_package()-ed again
    list(REMOVE_AT depend_list 0)
    find_package(${racebot_control_dep} REQUIRED NO_MODULE ${depend_list})
  endif()
  _list_append_unique(racebot_control_INCLUDE_DIRS ${${racebot_control_dep}_INCLUDE_DIRS})

  # merge build configuration keywords with library names to correctly deduplicate
  _pack_libraries_with_build_configuration(racebot_control_LIBRARIES ${racebot_control_LIBRARIES})
  _pack_libraries_with_build_configuration(_libraries ${${racebot_control_dep}_LIBRARIES})
  _list_append_deduplicate(racebot_control_LIBRARIES ${_libraries})
  # undo build configuration keyword merging after deduplication
  _unpack_libraries_with_build_configuration(racebot_control_LIBRARIES ${racebot_control_LIBRARIES})

  _list_append_unique(racebot_control_LIBRARY_DIRS ${${racebot_control_dep}_LIBRARY_DIRS})
  list(APPEND racebot_control_EXPORTED_TARGETS ${${racebot_control_dep}_EXPORTED_TARGETS})
endforeach()

set(pkg_cfg_extras "")
foreach(extra ${pkg_cfg_extras})
  if(NOT IS_ABSOLUTE ${extra})
    set(extra ${racebot_control_DIR}/${extra})
  endif()
  include(${extra})
endforeach()
