import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoFeedScreen extends StatefulWidget {
  @override
  _VideoFeedScreenState createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  final List<Map<String, String>> videoData = [
    {
      'username': 'Noe Alejandro',
      'userhandle': '@Noeon',
      'profileImage': 'https://yt3.googleusercontent.com/LSzYgCI1omHqqJ_kwGclTsZ68_jstIUpJNMjL64D0pD8vJrNEmXz5QFfC05zn5PHe4UGhKpyKw=s900-c-k-c0x00ffffff-no-rj',
      'videoUrl':'https://kenstudioucket.s3.us-east-1.amazonaws.com/Minion%20tarolero.mp4?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFIaCXVzLWVhc3QtMSJIMEYCIQDD97CRsTIUYcVp1%2BsDG661NFR4CSXIvBr4TE1CzrxMUQIhAPp9pWTrVQFg4InK9f94uBPxNncN45pN65qBKKHjW7ELKuwDCPr%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQARoMOTE0MTA0NzYxNDU2IgxTvDYxOhJATIpq3c8qwANs%2FW8Mq%2BYJncVYYXFy4nNoFq4TgJTk0S%2B%2BrnLIyGS91sdD6KhKAJPfHz52X5H8B7pVnK3B%2FGTwFHMhGQ61V4Sn7nmm3muH9RivqXEi4SdIZle1uRTl7XnLVJroTcpReUAtgzaA5uqCp6zPMLWQp9Fm9RHAI0tgV56pYoFOBShGLvKFrolVXySKf%2FQ6t4QAcGh0aFeo7699b7eVCLxOCBpwtAeFaMvTVILHzE0XmMKe9pw%2BjtlVR4tfwx0%2BpPCdl7BXf25WMLleVGdUKda%2FiGRrE7NCbv34%2Bjetexq6qjkFlUXLfO43yR51jHlBQl%2BdvlLJIx0VUGCRPcQDgpP7vcfkYN2ZFIWfYNqXddHHkYWdjUUD3UYFlqRT1UUE9g%2BhUuEHcZvqZiM6yqKayRU9%2Fu4x1V45f43LiSQfiokXwP7aTViCWcwEZfzj8dAvs6uOblSnwKXr3Hv%2BIdEoneoTMdRBDWEYshDnQ9P6oCgfJ6j%2FWTRaPUlBxDPAMJ90vZsPCVCRWzqDzbyWJ2bXAXvgKVbzVNiVVGPlxjbaLPglNoXBTy12wg9Thj8tbd3Zw1kY3U%2FRXV9UZP18J%2BZARUOe%2BpPOMPT7w7oGOrYC4JsbSt2vobtodzBDpJAy5tPJpSmLKAhDWANiduEb6Pwi9KRiVglB%2F4Mcom%2FoHyRSY4lYj%2F9sUZ1sGTFYRNfWBark7G3UkhniWF54Ck5fn1zOq41MQKAuZfN1Xk4QQv%2FsFnHLVVPm5KF94%2B8bGDY0X05rvKN4uX576k4ZtjzZoAeCoEr4ivi8xPCJOZOhTFVL7fW0BlO8LQcQ0W1cqDZepCgaqZzqEljI%2BykcctJv5bmaJBVpuNr9WX0PhsIF4tFOBr3PAgJGvv4BcZTOm43ENQDXVLswLVl%2BngkuLzOz999SBYSHNNI9sTHqAcwK8zJ8K7t4mMsxFb9pecfpP3pgXtpKCXaGq8uce4pHwQjtwvMY9U1y0UzwCPWn4sa03%2FckyFWmdpcQ2ZoO%2FuYGEktGE6ExXSfxuw%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA5JVHDXRYJNQEXR7Q%2F20241205%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241205T011703Z&X-Amz-Expires=7200&X-Amz-SignedHeaders=host&X-Amz-Signature=01a302524492457c265fdc4bb74464c8f023a59cdf6abd759edd311b8e6afe40', 'title': 'Evento de 15 años',
      'description': 'Me disfrace de minion y anduve bien arrecho'
    },
    {
      'username': 'María García',
      'userhandle': '@mariagarcia',
      'profileImage': 'https://scontent.ftgz2-1.fna.fbcdn.net/v/t39.30808-6/361609173_290338383516902_148942040969675955_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeGiqzfyU-sYlnidhtQxNeiYB0AuegqO28sHQC56Co7byxadzn9MZs06SzWLAtXT6lLUj0OpHfrh_g61sDnZeKEr&_nc_ohc=vNo9xE1VF1oQ7kNvgFbfZpy&_nc_zt=23&_nc_ht=scontent.ftgz2-1.fna&_nc_gid=AcLMmhJdh9MaoOrjwEU1WuH&oh=00_AYAwnf2Ca433O6PJL-F4VtXkzUEaRzi6ngH6DVSTJVeEjA&oe=671E106F',
      'videoUrl': 'https://kenstudioucket.s3.us-east-1.amazonaws.com/Mon%20Laferte%20-%20La%20Nave%20Del%20Olvido%20%28Letra_Lyrics%29%20_%20Homenaje%20a%20Jos%C3%A9%20Jos%C3%A9%2C%20Vive%20Lat.mp4?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFIaCXVzLWVhc3QtMSJIMEYCIQDD97CRsTIUYcVp1%2BsDG661NFR4CSXIvBr4TE1CzrxMUQIhAPp9pWTrVQFg4InK9f94uBPxNncN45pN65qBKKHjW7ELKuwDCPr%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQARoMOTE0MTA0NzYxNDU2IgxTvDYxOhJATIpq3c8qwANs%2FW8Mq%2BYJncVYYXFy4nNoFq4TgJTk0S%2B%2BrnLIyGS91sdD6KhKAJPfHz52X5H8B7pVnK3B%2FGTwFHMhGQ61V4Sn7nmm3muH9RivqXEi4SdIZle1uRTl7XnLVJroTcpReUAtgzaA5uqCp6zPMLWQp9Fm9RHAI0tgV56pYoFOBShGLvKFrolVXySKf%2FQ6t4QAcGh0aFeo7699b7eVCLxOCBpwtAeFaMvTVILHzE0XmMKe9pw%2BjtlVR4tfwx0%2BpPCdl7BXf25WMLleVGdUKda%2FiGRrE7NCbv34%2Bjetexq6qjkFlUXLfO43yR51jHlBQl%2BdvlLJIx0VUGCRPcQDgpP7vcfkYN2ZFIWfYNqXddHHkYWdjUUD3UYFlqRT1UUE9g%2BhUuEHcZvqZiM6yqKayRU9%2Fu4x1V45f43LiSQfiokXwP7aTViCWcwEZfzj8dAvs6uOblSnwKXr3Hv%2BIdEoneoTMdRBDWEYshDnQ9P6oCgfJ6j%2FWTRaPUlBxDPAMJ90vZsPCVCRWzqDzbyWJ2bXAXvgKVbzVNiVVGPlxjbaLPglNoXBTy12wg9Thj8tbd3Zw1kY3U%2FRXV9UZP18J%2BZARUOe%2BpPOMPT7w7oGOrYC4JsbSt2vobtodzBDpJAy5tPJpSmLKAhDWANiduEb6Pwi9KRiVglB%2F4Mcom%2FoHyRSY4lYj%2F9sUZ1sGTFYRNfWBark7G3UkhniWF54Ck5fn1zOq41MQKAuZfN1Xk4QQv%2FsFnHLVVPm5KF94%2B8bGDY0X05rvKN4uX576k4ZtjzZoAeCoEr4ivi8xPCJOZOhTFVL7fW0BlO8LQcQ0W1cqDZepCgaqZzqEljI%2BykcctJv5bmaJBVpuNr9WX0PhsIF4tFOBr3PAgJGvv4BcZTOm43ENQDXVLswLVl%2BngkuLzOz999SBYSHNNI9sTHqAcwK8zJ8K7t4mMsxFb9pecfpP3pgXtpKCXaGq8uce4pHwQjtwvMY9U1y0UzwCPWn4sa03%2FckyFWmdpcQ2ZoO%2FuYGEktGE6ExXSfxuw%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA5JVHDXRYJNQEXR7Q%2F20241205%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241205T011754Z&X-Amz-Expires=7200&X-Amz-SignedHeaders=host&X-Amz-Signature=060f70bb8961e766a58b5cf54a67c016bec9c2b327820effaf61a3e9a9494180',
      'title': 'Cover - la nave del olvido',
      'description': 'Improvisando en concierto en vivo #música #street'
    },
    {
      'username': 'Juan Pérez',
      'userhandle': '@juanperez',
      'profileImage': 'https://i.kym-cdn.com/photos/images/facebook/002/295/694/056.jpg',
      'videoUrl': 'https://kenstudioucket.s3.us-east-1.amazonaws.com/Mon%20Laferte%20-%20La%20Nave%20Del%20Olvido%20%28Letra_Lyrics%29%20_%20Homenaje%20a%20Jos%C3%A9%20Jos%C3%A9%2C%20Vive%20Lat.mp4?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEBoaCXVzLWVhc3QtMSJHMEUCIQDxIk3D270uULWuI1yu7USQgOxbhbHbsFUsoEkifGp7zQIgUCTgwi%2Bfm9rmLWURKN5y997Z7Fb8TPW7onvTMQ%2BXj7Qq7AMIk%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARABGgw5MTQxMDQ3NjE0NTYiDMiuQjbYHgpLOCuxfSrAA%2BGls0fMYjHyoz2MP43lPf%2BgyOuQpRpis1LFDy9iYZ1O5yuzFZKWi%2BPK%2FUV7Pz5a0oKJ9ur%2BL4AM6F6N4Sr4MgJw5VSjs2pRHmpaOB%2FEdJveC6xs3y0XFZozIZXzQnGPWctwKFfIRlliH854pQtef98DcsrjE7jN7sdh2dkqEO0Cr86HrFxbDFlwvfgoiiU1sOvMeiOSSMgSRwsmRL9%2FhN6ZSf15x77U%2BsJql%2FHLXkhZbvQDzVkHgGCnQFRG37f7RvUK5t5%2BWWJkhy5S23tbfzHOinXYsXDoW8znywWbfHizG6ypyHK6tCNiq1yLzsHcPzAYx%2FsmuqCWMDsteBJNhxZ8w4EEgqoThMTyc%2FwV18c4TiQm4c%2FANQRf58rKIeHObm6jXmXH7ThN%2FpMMlAhiwk8YgL%2FW1h2ukI190GBxiyEBukUm%2F5zAm7NiDBob43vdxNZ6xoTbkwgYlyj7Hbfq4Mm%2BInK79QU0slfFRkpH3ADd4TDEU4iQA2GQCxbEYnYSVZSsjquye3qtAbnAbH1lRWmhbweojFlqX%2F2gzDPaTqE3pAWhyeIyrY5BZpHQtckTVHK0gmYIx2ny3SxNfA%2Fd8AYw8%2FSOuQY6twKTD2gkvWNMPM0XXqx%2FGD4AKSWV5wg3aK%2Fsv18dvqSr81oMZr1l8l1YSCAKMMCK9iw7YQEbWCrKgJn9eWGQDq0fj0RknMC2bt9BXkV8VRqzipdvSeT0snMMMFmAsQ4JXo7KXenalKvX%2FFRn80KL8bGMC89DiYhEVgbQBbLJ3agnL7aiKoe3hUFs8ci%2BQLF9bd4CtFt6ak8RmhxzZtDMS4ndNpwlLcAfa8jXdj2wlCfPVyaJWW%2B85cVhAM6Z0svUzWxeVo5HOs47dSRWjYGwkTSXhKaYVpkbloyZ4nAHN8doAiyrucQP4BjR4pi02%2BJHYxPdbvkB%2FFatKqS1pewcNBAPKExpg6ZvduXGJ720lhHSKdZ%2FRsES00g6B88dhDFT%2FI8%2FO%2BtHNID4ySs7MiwRNMVF2WWB0onZIg%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA5JVHDXRYG2UFFBKM%2F20241031%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241031T172639Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=c4011e7396cbcdfab9cc23bc5e3a0dc17f967f4c2fef581a25f4042bc3713ea9',
      'title': 'Mon Laferte - Cover La nave del olvido',
      'description': 'Presentación de danza folclórica en la plaza central.'
    },
  ];
  late PageController _pageController;
  VideoPlayerController? _videoController; // Cambiar a tipo opcional
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeVideo(videoData[_currentPage]);

    _pageController.addListener(() {
      int nextPage = _pageController.page!.round();
      if (_currentPage != nextPage) {
        setState(() {
          _currentPage = nextPage;
        });
        _initializeVideo(videoData[_currentPage]);
      }
    });
  }

  void _initializeVideo(Map<String, String> videoInfo) {
    _videoController?.dispose();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(videoInfo['videoUrl']!))
      ..initialize().then((_) {
        setState(() {});
        _videoController!.play();
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoController?.dispose(); // Asegúrate de que _videoController no sea nulo
    super.dispose();
  }

  void _goToProfile(String username) {
    // Aquí puedes navegar a la pantalla del perfil del usuario
     Navigator.pushNamed(context, '/userProfile');
    print('Navegando al perfil de: $username'); // Esta línea es solo para pruebas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Reels', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videoData.length,
        itemBuilder: (context, index) {
          final videoInfo = videoData[index]; // Obtiene la información del video
          return Stack(
            children: [
              Center(
                child: _videoController?.value.isInitialized == true
                    ? AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      )
                    : CircularProgressIndicator(),
              ),
              // Información de usuario y descripción del video
              Positioned(
                bottom: 100,
                left: 20,
                right: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Cambiar a start para alinear arriba
                  children: [
                    // Avatar del usuario
                    GestureDetector(
                      onTap: () => _goToProfile(videoInfo['username']!), // Navegar al perfil del usuario
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(videoInfo['profileImage']!), // Usar la imagen del perfil
                      ),
                    ),
                    SizedBox(width: 10),
                    // Información de usuario y descripción
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Nombre del usuario
                          Text(
                            videoInfo['username']!, 
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          // Handle del usuario
                          Text(
                            videoInfo['userhandle']!, // Handle del usuario
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          // Título del video
                          Text(
                            videoInfo['title']!, 
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          // Descripción del video
                          Text(
                            videoInfo['description']!, 
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    // Ícono de música
                    Icon(Icons.music_note, color: Colors.white, size: 24),
                  ],
                ),
              ),
              // Botón de play/pause en la parte inferior
              Positioned(
                bottom: 20,
                left: 20,
                child: IconButton(
                  icon: Icon(
                    _videoController?.value.isPlaying == true ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_videoController != null) {
                        _videoController!.value.isPlaying
                            ? _videoController!.pause()
                            : _videoController!.play();
                      }
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
