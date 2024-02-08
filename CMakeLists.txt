cmake_minimum_required(VERSION 3.16)

project(customItemsUsingQml VERSION 0.1 LANGUAGES CXX)
set(
    SOURCE_FILES  MusicPlayerController/musicplayercontroller.h MusicPlayerController/musicplayercontroller.cpp
    AudioInfo/audioinfo.h AudioInfo/audioinfo.cpp
    Util/util.h Util/util.cpp
)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Multimedia)
include_directories(AudioInfo)
qt_standard_project_setup()
qt_add_executable(appcustomItemsUsingQml
    main.cpp ${SOURCE_FILES}
)

qt_add_qml_module(appcustomItemsUsingQml
    URI Resources
    VERSION 1.0
    SOURCES
    RESOURCES assets.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appcustomItemsUsingQml PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appcustomItemsUsingQml
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appcustomItemsUsingQml
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Multimedia
)

include(GNUInstallDirs)
install(TARGETS appcustomItemsUsingQml
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
