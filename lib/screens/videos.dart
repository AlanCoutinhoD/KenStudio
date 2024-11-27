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
      'videoUrl': 'https://kenstudioucket.s3.us-east-1.amazonaws.com/happi%20happi%20happi%20%23shorts%20%23happyhappyhappy%20%23catmemes%20%23cat%20%23meme%20%23trending%20%23spyde.mp4?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEJX%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIErpR473ik6fZ8OzUk7iNsi2A%2Bh3KNqR1KqOFOe6jwKGAiEAjEd9Q8jz%2F1r%2BBaqxh%2Fu6PJnN8pW%2FZCX6tHkJJz9VOVEq4wMIHhABGgw5MTQxMDQ3NjE0NTYiDEPNOjUuOjOnE2OxEirAA9E0IgVKBgtbl8xBZeLs0b%2BV6bHU9k1XCl5STpPfPempVONtW8jvHPaXAeYV5e%2B%2FXpCfjlU%2F53HBVdTCwOOXXhX%2BrO3W8a1hjBxAzSeeVFvQBUfblF153nuqecpo9knDnUVqh9NL9yBFA4hTVL%2BOiJ%2FvS0tB3H5B79%2B9MZUjTJJMCwGO8C%2ByaADn1ldvWqBACntdpsXIjas58joRH%2BLYtIxxesRFShhWTCfXEfh%2Fj6U%2BBf40FZiAN40nppTgNjlBaOtnbD5p%2FQSN%2B383AbMCfsykfwP8tu8W6Dar77Q%2FH%2BRf9nbMcDmWx84gRKlZpC1o0M%2FzWxJkhDxqSCBzyP2Ks%2FBVqXN%2Bp%2FQr4I9fUZmUmumrDa9jkfcZGTSM7UKKFehs2dZBLIUp5SFNadtD5iZ8uioikAhT2Z8FxPGAZ%2FZLFqVMFitA0YYZakBRkzEO5oqIb%2BRQ0wW8fJkNLVHnCfjeyZiZwcz1Nayy4H5kOalQVFfE0vpirz05fz7PYOocgw2v7DIg55gj2GxtMDlWGlE5Sk0Xa%2FraqdfpLljtE86UJmZx5RvWghkazF%2Bkd%2BKpMV60bX6N2QIa3tDkODgHd2Hipp0wutupuQY6twKGJITkkchq4%2FVoxXd6I%2FB8hfHDvdJl667auEliNiLcqjgcjLLSAapwz%2BpvNCkdJwDvp6IsCf8iMJgo1AIOvDU7VLg9z8EDcnqPUCB8aTwqzxV1OvXf%2F3ufFGd3AEzL%2B4QaolRbGRIGI0dmsrNHJiOTwaolakR7xrU%2B5aPIB3YLWeAfpjZYVClBVuQObxdjI1iTF3p2sBZgPaVjojpKFEpd9UlfY8fHMofZXQzF4X%2FDcsFKFSBdAv6f9ZYU2ehWpD%2FVv5WF6wRcltpvE1xWFUhewOxHeCnNVAbdvWKWT%2B%2BXI9ylbhJU7B0tLvivkHnejffQtEIwqbIrjl%2By7XxTr3zctG9mKpvDrDszONkUi3eG5pACaRk9%2FrmaiIeWQdNOmXBRkjOaom8s6Rpa2c7AaCkhT%2FQ2bX1qvw%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA5JVHDXRYH4O2IMR4%2F20241105%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241105T203804Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=151d5ea58cf25ba8ab3b4093a195ed53d4ec1e607ddb40e2ab6da99a3a8b9b6b',
      'title': 'Evento de 15 años',
      'description': 'Me disfrace de minion y anduve bien arrecho'
    },
    {
      'username': 'María García',
      'userhandle': '@mariagarcia',
      'profileImage': 'https://scontent.ftgz2-1.fna.fbcdn.net/v/t39.30808-6/361609173_290338383516902_148942040969675955_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeGiqzfyU-sYlnidhtQxNeiYB0AuegqO28sHQC56Co7byxadzn9MZs06SzWLAtXT6lLUj0OpHfrh_g61sDnZeKEr&_nc_ohc=vNo9xE1VF1oQ7kNvgFbfZpy&_nc_zt=23&_nc_ht=scontent.ftgz2-1.fna&_nc_gid=AcLMmhJdh9MaoOrjwEU1WuH&oh=00_AYAwnf2Ca433O6PJL-F4VtXkzUEaRzi6ngH6DVSTJVeEjA&oe=671E106F',
      'videoUrl': 'https://kenstudioucket.s3.us-east-1.amazonaws.com/Minion%20tarolero.mp4?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEJX%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIErpR473ik6fZ8OzUk7iNsi2A%2Bh3KNqR1KqOFOe6jwKGAiEAjEd9Q8jz%2F1r%2BBaqxh%2Fu6PJnN8pW%2FZCX6tHkJJz9VOVEq4wMIHhABGgw5MTQxMDQ3NjE0NTYiDEPNOjUuOjOnE2OxEirAA9E0IgVKBgtbl8xBZeLs0b%2BV6bHU9k1XCl5STpPfPempVONtW8jvHPaXAeYV5e%2B%2FXpCfjlU%2F53HBVdTCwOOXXhX%2BrO3W8a1hjBxAzSeeVFvQBUfblF153nuqecpo9knDnUVqh9NL9yBFA4hTVL%2BOiJ%2FvS0tB3H5B79%2B9MZUjTJJMCwGO8C%2ByaADn1ldvWqBACntdpsXIjas58joRH%2BLYtIxxesRFShhWTCfXEfh%2Fj6U%2BBf40FZiAN40nppTgNjlBaOtnbD5p%2FQSN%2B383AbMCfsykfwP8tu8W6Dar77Q%2FH%2BRf9nbMcDmWx84gRKlZpC1o0M%2FzWxJkhDxqSCBzyP2Ks%2FBVqXN%2Bp%2FQr4I9fUZmUmumrDa9jkfcZGTSM7UKKFehs2dZBLIUp5SFNadtD5iZ8uioikAhT2Z8FxPGAZ%2FZLFqVMFitA0YYZakBRkzEO5oqIb%2BRQ0wW8fJkNLVHnCfjeyZiZwcz1Nayy4H5kOalQVFfE0vpirz05fz7PYOocgw2v7DIg55gj2GxtMDlWGlE5Sk0Xa%2FraqdfpLljtE86UJmZx5RvWghkazF%2Bkd%2BKpMV60bX6N2QIa3tDkODgHd2Hipp0wutupuQY6twKGJITkkchq4%2FVoxXd6I%2FB8hfHDvdJl667auEliNiLcqjgcjLLSAapwz%2BpvNCkdJwDvp6IsCf8iMJgo1AIOvDU7VLg9z8EDcnqPUCB8aTwqzxV1OvXf%2F3ufFGd3AEzL%2B4QaolRbGRIGI0dmsrNHJiOTwaolakR7xrU%2B5aPIB3YLWeAfpjZYVClBVuQObxdjI1iTF3p2sBZgPaVjojpKFEpd9UlfY8fHMofZXQzF4X%2FDcsFKFSBdAv6f9ZYU2ehWpD%2FVv5WF6wRcltpvE1xWFUhewOxHeCnNVAbdvWKWT%2B%2BXI9ylbhJU7B0tLvivkHnejffQtEIwqbIrjl%2By7XxTr3zctG9mKpvDrDszONkUi3eG5pACaRk9%2FrmaiIeWQdNOmXBRkjOaom8s6Rpa2c7AaCkhT%2FQ2bX1qvw%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA5JVHDXRYH4O2IMR4%2F20241105%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241105T203924Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=a8791ffd0b91a1dadee04d6eb8993b26fa71bd61863e1d718838e1a558bc119b',
      'title': 'Un MINION',
      'description': 'Improvisando con mi guitarra en las calles de Madrid #música #street'
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
