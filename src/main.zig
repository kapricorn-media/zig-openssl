const ssl = @cImport(@cInclude("openssl/ssl.h"));

pub fn main() void
{
    // ssl.init_openssl();

    const ctx: *ssl.SSL_CTX = undefined;// = ssl.create_context();
    _ = ctx;
    // ssl.configure_context(ctx);

    // const sock: c_int = ssl.create_socket(4433);
    // defer ssl.close(sock);
    // _ = sock;

    // /* Handle connections */
    // while(1) {
    //     struct sockaddr_in addr;
    //     uint len = sizeof(addr);
    //     SSL *ssl;
    //     const char reply[] = "test\n";

    //     int client = accept(sock, (struct sockaddr*)&addr, &len);
    //     if (client < 0) {
    //         perror("Unable to accept");
    //         exit(EXIT_FAILURE);
    //     }

    //     ssl = SSL_new(ctx);
    //     SSL_set_fd(ssl, client);

    //     if (SSL_accept(ssl) <= 0) {
    //         ERR_print_errors_fp(stderr);
    //     }
    //     else {
    //         SSL_write(ssl, reply, strlen(reply));
    //     }

    //     SSL_shutdown(ssl);
    //     SSL_free(ssl);
    //     close(client);
    // }

    // close(sock);
    // SSL_CTX_free(ctx);
    // cleanup_openssl();
    // TODO something...
}
